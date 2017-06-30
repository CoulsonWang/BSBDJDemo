//
//  BDJTopicCellSoundView.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJTopicCellSoundView.h"
#import "BDJEssenceTopicItem.h"
#import "UIImageView+Download.h"

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
    
    [self.imageView YY_setOriginalImage:item.image1 thumbnailImage:item.image0 placeholderImage:nil];
    
    //播放数量
    if (item.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f次播放",item.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%ld次播放",item.playcount];
    }
    
    //音频时长
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",item.voicetime / 60,item.voicetime % 60];
}



@end
