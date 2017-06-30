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

static CGFloat const SpaceBetweenCells = 10.0;
static CGFloat const SpaceBetweenViews = 10.0;

@interface BDJEssenceTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *conmentButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightConstraint;

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

/**
 重写setFrame方法来实现cell之间有间距
 */
- (void)setFrame:(CGRect)frame {
    frame.size.height -= SpaceBetweenCells;
    [super setFrame:frame];
}

/**
 计算并返回cell的高度

 @return cell的高度值
 */
- (CGFloat)cellHeight {
    CGFloat cellHeight = 0;
    //加上顶部视图高度
    cellHeight +=_topViewHeightConstraint.constant;
    //计算文本高度
    CGFloat textWidth = self.YY_width - 2 * SpaceBetweenViews;
    UIFont *textFont = self.text_label.font;
    CGFloat textHeight = [self.item.text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size.height;
    //加上文本高度
    cellHeight += textHeight;
    //加上文本高度和底部工具条的间距
    cellHeight += SpaceBetweenViews;
    //加上底部工具条高度
    cellHeight += _bottomViewHeightConstraint.constant;
    //加上cell之间的间距
    cellHeight += SpaceBetweenCells;
    
    return cellHeight;
}




@end
