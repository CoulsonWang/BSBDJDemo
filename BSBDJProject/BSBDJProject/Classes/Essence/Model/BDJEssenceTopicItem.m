//
//  BDJEssenceTopicItem.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/29.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceTopicItem.h"

@implementation BDJEssenceTopicItem

- (CGFloat)cellHeight {
    //如果已经计算过，直接返回
    if (_cellHeight) return _cellHeight;
    
    //如果没计算过，则初始为0
    _cellHeight += 60;
    //计算文本高度
    CGFloat contentWidth = screenW - 2 * SpaceOfMargin;
    UIFont *textFont = [UIFont systemFontOfSize:15];
    CGFloat textHeight = [self.text boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size.height;
    //加上文本高度
    _cellHeight += textHeight;
    //加上文本和下方控件的间距
    _cellHeight += SpaceOfMargin;
    
    //中间内容的高度
    if (self.type != BDJTopicTypeCrossTalk) {
        //需要显示的图片的高度
        CGFloat imageHeight = contentWidth / self.width * self.height;
        //如果图片的高度超过了控制器view的高度，且图片不是gif
        if (self.type == BDJTopicTypePhoto && imageHeight >= screenH - NavigationBarHeight - TitleHeight - TabBarHeight && ![self.is_gif boolValue]) {
            imageHeight = 250;
            self.longPicture = YES;
        }
        self.middelFrame = CGRectMake(SpaceOfMargin, _cellHeight, contentWidth, imageHeight);
        //加上图片高度
        _cellHeight += imageHeight;
        //加上中间内容与下方控件的间距
        _cellHeight += SpaceOfMargin;
    }
    
    //最热评论的高度
    if (self.top_cmt.count) {
        //评论头的高度
        _cellHeight += 18;
        //计算评论正文的高度
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *comment = [NSString stringWithFormat:@"%@:%@",username,content];
        UIFont *commentFont = [UIFont systemFontOfSize:14];
        CGFloat commentHeigth = [comment boundingRectWithSize:CGSizeMake(contentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:commentFont} context:nil].size.height;
        //加上评论正文的高度
        _cellHeight += commentHeigth;
        //加上最热评论与下方控件的间距
        _cellHeight += SpaceOfMargin;
    }
    //加上底部工具条高度
    _cellHeight += 30;
    //加上cell之间的间距
    _cellHeight += SpaceOfMargin;
    
    return _cellHeight;
}

@end
