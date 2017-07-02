//
//  UIImageView+Download.m
//  检测当前网络状态，通过URL自动下载高清图或缩略图
//
//  Created by Coulson_Wang on 2017/6/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "UIImageView+Download.h"
#import <UIImageView+WebCache.h>
#import <AFNetworkReachabilityManager.h>

@implementation UIImageView (Download)

- (void)YY_setOriginalImage:(NSString *)originalImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage completion:(SDExternalCompletionBlock)completionBlock {
    
    //根据网络状况决定加载什么图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //先去缓存中取保存的高清图片
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageURL];
    //如果缓存中已经有高清图片，则直接赋值不再下载
    if (originalImage) {
        self.image = originalImage;
        if (completionBlock) {
            completionBlock(originalImage,nil,0,[NSURL URLWithString:originalImageURL]);
        }
    } else {
        //如果缓存中没有高清图片，再去判断当前网络状态。如果是WIFI直接下载高清图片
        if (mgr.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage completed:completionBlock];
        } else if (mgr.isReachableViaWWAN) {
            //判断3G\4G网络下是否允许下载高清图片
            BOOL downloadOriginalImageWhenUseWWAN = NO;
            if (downloadOriginalImageWhenUseWWAN) {
                //如果允许，直接下载高清图片
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageURL] placeholderImage:placeholderImage completed:completionBlock];
            } else {
                //如果不允许，下载缩略图
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholderImage completed:completionBlock];
            }
            //如果没有网络，尝试去缓存中取缩略图
        } else {
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];;
            if (thumbnailImage) {
                //如果缓存中有缩略图，则显示缩略图
                self.image = thumbnailImage;
                if (completionBlock) {
                    completionBlock(originalImage,nil,0,[NSURL URLWithString:originalImageURL]);
                }
            } else {
                //如果缓存中没有，显示占位图片
                self.image = placeholderImage;
            }
        }
    }
}

@end
