//
//  BDJTopicCellSoundView.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJTopicCellSoundView.h"
#import "BDJEssenceTopicItem.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface BDJTopicCellSoundView ()
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;

@end

@implementation BDJTopicCellSoundView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setItem:(BDJEssenceTopicItem *)item {
    _item = item;
    
    [self setUpImageWithItem:item];
    
    //播放数量
    if (item.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f次播放",item.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%ld次播放",item.playcount];
    }
    
    //音频时长
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",item.voicetime / 60,item.voicetime % 60];
}

- (void)setUpImageWithItem:(BDJEssenceTopicItem *)item {
    
    UIImage *placeholderImage = nil;
    //根据网络状况决定加载什么图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //先去缓存中取保存的高清图片
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.image1];
    //如果缓存中已经有高清图片，则直接赋值不再下载
    if (originalImage) {
        self.imageView.image = originalImage;
    } else {
        //如果缓存中没有高清图片，再去判断当前网络状态。如果是WIFI直接下载高清图片
        if (mgr.isReachableViaWiFi) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.image1] placeholderImage:placeholderImage];
        } else if (mgr.isReachableViaWWAN) {
            //判断3G\4G网络下是否允许下载高清图片
            BOOL downloadOriginalImageWhenUseWWAN = NO;
            if (downloadOriginalImageWhenUseWWAN) {
                //如果允许，直接下载高清图片
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.image1] placeholderImage:placeholderImage];
            } else {
                //如果不允许，下载缩略图
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.image0] placeholderImage:placeholderImage];
            }
            //如果没有网络，尝试去缓存中取缩略图
        } else {
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.image0];;
            if (thumbnailImage) {
                //如果缓存中有缩略图，则显示缩略图
                self.imageView.image = thumbnailImage;
            } else {
                //如果缓存中没有，显示占位图片
                self.imageView.image = placeholderImage;
            }
        }
    }
}

@end
