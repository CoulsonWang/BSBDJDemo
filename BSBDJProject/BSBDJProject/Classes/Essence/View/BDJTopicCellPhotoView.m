//
//  BDJTopicCellPhotoView.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJTopicCellPhotoView.h"
#import "BDJEssenceTopicItem.h"
#import "UIImageView+Download.h"
#import <FLAnimatedImageView+WebCache.h>

@interface BDJTopicCellPhotoView ()

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *checkBigPictureButton;

@end

@implementation BDJTopicCellPhotoView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [self setUpGesture];
}

- (void)setItem:(BDJEssenceTopicItem *)item {
    _item = item;
    
    
    BOOL isGif = [item.is_gif boolValue];
    //GIF
    if (isGif) {
        self.gifView.hidden = NO;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.image1]];
    } else {
        self.gifView.hidden = YES;
        [self.imageView YY_setOriginalImage:item.image1 thumbnailImage:item.image0 placeholderImage:nil completion:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (!image) return;
            if (item.isLongPicture) {
                self.imageView.image = [self createImage:image item:item];
            }
        }];
    }
    //超长图片
    if (item.isLongPicture) {
        self.checkBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
    } else {
        self.checkBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

/**
 处理超长图片的图片尺寸

 @param originImage 原始图片
 @param item 模型
 @return 修改尺寸以后的图片
 */
- (UIImage *)createImage:(UIImage *)originImage item:(BDJEssenceTopicItem *)item {
    CGFloat contentWidth = item.middelFrame.size.width;
    CGFloat contentHeight = item.height * contentWidth / item.width;
    UIGraphicsBeginImageContext(CGSizeMake(contentWidth, contentHeight));
    [originImage drawInRect:CGRectMake(0, 0, contentWidth, contentHeight)];
    UIImage *fixedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return fixedImage;
}

//添加点击手势
- (void)setUpGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture)];
    [self.imageView addGestureRecognizer:tap];
}

//处理点击手势
- (void)tapPicture {
    NSDictionary *userInfo = @{
                               @"topicItem" : self.item
                               };
    //发送通知，让精华控制器处理点击事件
    [[NSNotificationCenter defaultCenter] postNotificationName:BDJPhotoViewDidClickNotification object:nil userInfo:userInfo];
}

@end
