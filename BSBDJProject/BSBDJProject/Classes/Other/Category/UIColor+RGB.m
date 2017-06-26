//
//  UIColor+RGB.m
//  根据RGB生成颜色
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor (RGB)

+ (instancetype)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b {
    return [self colorWithR:r G:g B:b alpha:1.0];
}

+ (instancetype)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha {
    UIColor *color = [self colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    return color;
}

@end
