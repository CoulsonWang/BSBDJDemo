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
    
    
}

- (void)setItem:(BDJEssenceTopicItem *)item {
    _item = item;
    
    
    BOOL isGif = [item.is_gif boolValue];
    if (isGif) {
        self.gifView.hidden = NO;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.image1]];
    } else {
        self.gifView.hidden = YES;
        [self.imageView YY_setOriginalImage:item.image1 thumbnailImage:item.image0 placeholderImage:nil];
    }
}

@end
