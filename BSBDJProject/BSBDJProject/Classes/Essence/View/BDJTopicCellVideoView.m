//
//  BDJEssenceTopicVideoView.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJTopicCellVideoView.h"
#import "BDJEssenceTopicItem.h"
#import "UIImageView+Download.h"
#import <AVFoundation/AVFoundation.h>

@interface BDJTopicCellVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;


@end

@implementation BDJTopicCellVideoView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setItem:(BDJEssenceTopicItem *)item {
    _item = item;
    
    [self.imageView YY_setOriginalImage:item.image1 thumbnailImage:item.image0 placeholderImage:nil];
    
    //播放数量
    if (item.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万次播放",item.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%ld次播放",item.playcount];
    }
    
    //音频时长
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",item.videotime / 60,item.videotime % 60];
}

- (IBAction)playButtonClick:(UIButton *)sender {
    
}

@end
