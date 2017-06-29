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

@interface BDJEssenceTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *conmentButton;

@end

@implementation BDJEssenceTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.profileImageView.layer.cornerRadius = self.profileImageView.YY_width * 0.5;
    self.profileImageView.layer.masksToBounds = YES;
    
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
}

- (void)setUpButtonTitle:(UIButton *)button number:(NSString *)Titlenumber placeholder:(NSString *)placeholder {
    NSUInteger number = [Titlenumber integerValue];
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%f万",number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%ld",number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
