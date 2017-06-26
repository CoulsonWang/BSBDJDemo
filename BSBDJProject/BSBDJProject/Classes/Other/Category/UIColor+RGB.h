//
//  UIColor+RGB.h
//  根据RGB生成颜色
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGB)

+ (instancetype)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat) b;

+ (instancetype)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;

@end
