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
    CGFloat textWidth = screenW - 2 * 10;
    UIFont *textFont = [UIFont systemFontOfSize:15];
    CGFloat textHeight = [self.text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size.height;
    //加上文本高度
    _cellHeight += textHeight;
    //加上文本高度和底部工具条的间距
    _cellHeight += 10;
    //加上底部工具条高度
    _cellHeight += 30;
    //加上cell之间的间距
    _cellHeight += 10;
    
    return _cellHeight;
}

@end
