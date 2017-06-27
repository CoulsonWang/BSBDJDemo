//
//  UIView+Frame.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)YY_width {
    return self.frame.size.width;
}

- (void)setYY_width:(CGFloat)YY_width {
    CGRect frame = self.frame;
    frame.size.width = YY_width;
    self.frame = frame;
}


- (CGFloat)YY_height {
    return self.frame.size.height;
}

- (void)setYY_height:(CGFloat)YY_height {
    CGRect frame = self.frame;
    frame.size.height = YY_height;
    self.frame = frame;
}


- (CGFloat)YY_y {
    return self.frame.origin.y;
}

- (void)setYY_y:(CGFloat)YY_y {
    CGRect frame = self.frame;
    frame.origin.y = YY_y;
    self.frame = frame;
}


- (CGFloat)YY_x {
    return self.frame.origin.x;
}

- (void)setYY_x:(CGFloat)YY_x {
    CGRect frame = self.frame;
    frame.origin.x = YY_x;
    self.frame = frame;
}

- (CGFloat)YY_centerX {
    return self.center.x;
}

- (void)setYY_centerX:(CGFloat)YY_centerX {
    CGPoint center = self.center;
    center.x = YY_centerX;
    self.center = center;
}

- (CGFloat)YY_centerY {
    return self.center.y;
}

- (void)setYY_centerY:(CGFloat)YY_centerY {
    CGPoint center= self.center;
    center.y = YY_centerY;
    self.center = center;
}

@end
