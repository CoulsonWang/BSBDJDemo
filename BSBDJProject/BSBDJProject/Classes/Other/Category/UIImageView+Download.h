//
//  UIImageView+Download.h
//  检测当前网络状态，通过URL自动下载高清图或缩略图
//
//  Created by Coulson_Wang on 2017/6/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Download)

- (void)YY_setOriginalImage:(NSString *)originalImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholderImage:(UIImage *)placeholderImage;

@end
