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
#import <AVFoundation/AVFoundation.h>

@interface BDJTopicCellSoundView ()
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (assign, nonatomic, getter=isPlaying) BOOL playing;

@end

@implementation BDJTopicCellSoundView

- (void)setPlaying:(BOOL)playing {
    _playing = playing;
    if (playing) {
        [self.playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
    } else {
        [self.playButton setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)dealloc
{
    [_item removeObserver:self forKeyPath:@"soundPlayStatus"];
}

- (void)setItem:(BDJEssenceTopicItem *)item {
    [_item removeObserver:self forKeyPath:@"soundPlayStatus"];
    [item addObserver:self forKeyPath:@"soundPlayStatus" options:NSKeyValueObservingOptionNew context:nil];
    _item = item;
    
    [self.imageView YY_setOriginalImage:item.image1 thumbnailImage:item.image0 placeholderImage:nil];
    
    //播放数量
    if (item.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万次播放",item.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%ld次播放",item.playcount];
    }
    
    //音频时长
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",item.voicetime / 60,item.voicetime % 60];
    
    if (item.soundPlayStatus) {
        [self.playButton setImage:[UIImage imageNamed:@"playButtonPause"] forState:UIControlStateNormal];
    } else {
        [self.playButton setImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)playButtonClick:(UIButton *)sender {

    NSDictionary *userInfo = @{
                               @"soundItem":self.item
                               };
    [[NSNotificationCenter defaultCenter] postNotificationName:BDJSoundButtonDidClickNotification
                                                        object:nil
                                                      userInfo:userInfo];
}

//监听item中属性变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"soundPlayStatus"]) {
        NSNumber *status = change[@"new"];
        BOOL playStatus = [status boolValue];
        self.playing = playStatus;
    }
}


@end
