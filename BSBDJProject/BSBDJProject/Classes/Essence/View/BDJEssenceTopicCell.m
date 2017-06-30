//
//  BDJEssenceTopicCell.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/29.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceTopicCell.h"
#import "BDJEssenceTopicItem.h"
#import <UIImageView+WebCache.h>
#import "BDJTopicCellPhotoView.h"
#import "BDJTopicCellSoundView.h"
#import "BDJTopicCellVideoView.h"



@interface BDJEssenceTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *conmentButton;
@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@property (weak, nonatomic) IBOutlet UILabel *topCommentLabel;

@property (weak, nonatomic) UIImageView *topCommentBackgroundView;
@property (weak, nonatomic) BDJTopicCellPhotoView *photoView;
@property (weak, nonatomic) BDJTopicCellSoundView *soundView;
@property (weak, nonatomic) BDJTopicCellVideoView *videoView;

@end

@implementation BDJEssenceTopicCell

#pragma mark - Lazy Load

- (BDJTopicCellPhotoView *)photoView {
    if (!_photoView) {
        _photoView = [BDJTopicCellPhotoView YY_viewFromNib];
        [self.contentView addSubview:_photoView];
    }
    return _photoView;
}

- (BDJTopicCellSoundView *)soundView {
    if (!_soundView) {
        _soundView = [BDJTopicCellSoundView YY_viewFromNib];
        [self.contentView addSubview:_soundView];
    }
    return _soundView;
}

- (BDJTopicCellVideoView *)videoView {
    if (!_videoView) {
        _videoView = [BDJTopicCellVideoView YY_viewFromNib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

#pragma mark - Life Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.profileImageView.layer.cornerRadius = self.profileImageView.YY_width * 0.5;
    self.profileImageView.layer.masksToBounds = YES;
    
    UIImageView *topCommentBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    [self.topCommentView insertSubview:topCommentBackgroundView atIndex:0];
    self.topCommentBackgroundView = topCommentBackgroundView;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.topCommentBackgroundView.frame = self.topCommentView.bounds;
    
    if (self.item.type == BDJTopicTypePhoto) {
        self.photoView.frame = self.item.middelFrame;
    } else if (self.item.type == BDJTopicTypeSound) {
        self.soundView.frame = self.item.middelFrame;
    } else if (self.item.type == BDJTopicTypeVideo) {
        self.videoView.frame = self.item.middelFrame;
    }
}

- (void)setItem:(BDJEssenceTopicItem *)item {
    _item = item;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:item.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = item.name;
    self.passtimeLabel.text = item.passtime;
    self.text_label.text = item.text;

    [self setUpButtonTitle:self.dingButton number:item.ding placeholder:@"顶"];
    [self setUpButtonTitle:self.caiButton number:item.cai placeholder:@"踩"];
    [self setUpButtonTitle:self.repostButton number:item.repost placeholder:@"分享"];
    [self setUpButtonTitle:self.conmentButton number:item.comment placeholder:@"评论"];
    
    //处理最热评论是否隐藏以及显示的内容
    if (item.top_cmt.count) {
        self.topCommentView.hidden = NO;
        NSDictionary *cmt = item.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *comment = [NSString stringWithFormat:@"%@:%@",username,content];
        self.topCommentLabel.text = comment;
        
    } else {
        self.topCommentView.hidden = YES;
    }
    
    //判断帖子类型，添加相应的中间控件
    if (item.type == BDJTopicTypePhoto) {
        self.photoView.hidden = NO;
        self.soundView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (item.type == BDJTopicTypeSound) {
        self.photoView.hidden = YES;
        self.soundView.hidden = NO;
        self.videoView.hidden = YES;
        self.soundView.item = item;
    } else if (item.type == BDJTopicTypeVideo) {
        self.photoView.hidden = YES;
        self.soundView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.item = item;
    } else if (item.type == BDJTopicTypeCrossTalk) {
        self.photoView.hidden = YES;
        self.soundView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
}

- (void)setUpButtonTitle:(UIButton *)button number:(NSString *)Titlenumber placeholder:(NSString *)placeholder {
    NSUInteger number = [Titlenumber integerValue];
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%ld",number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/**
 重写setFrame方法来实现cell之间有间距
 */
- (void)setFrame:(CGRect)frame {
    frame.size.height -= SpaceBetweenCells;
    [super setFrame:frame];
}






@end
