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

@interface BDJTopicCellPhotoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@end

@implementation BDJTopicCellPhotoView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.gifView.hidden = YES;
}

- (void)setItem:(BDJEssenceTopicItem *)item {
    _item = item;
    
    [self.imageView YY_setOriginalImage:item.image1 thumbnailImage:item.image0 placeholderImage:nil];
    
}

@end
