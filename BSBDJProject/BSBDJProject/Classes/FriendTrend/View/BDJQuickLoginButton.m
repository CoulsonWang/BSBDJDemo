//
//  BDJQuickLoginButton.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJQuickLoginButton.h"

@implementation BDJQuickLoginButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.YY_y = 0;
    self.imageView.YY_centerX = self.YY_width * 0.5;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.YY_centerX = self.YY_width * 0.5;
    self.titleLabel.YY_y = self.YY_height - self.titleLabel.YY_height;
}

@end
