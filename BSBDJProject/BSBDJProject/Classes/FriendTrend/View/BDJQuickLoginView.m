//
//  BDJQuickLoginView.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJQuickLoginView.h"
#import "BDJQuickLoginButton.h"

@implementation BDJQuickLoginView

+ (instancetype)quickLoginView {
    BDJQuickLoginView *quickView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
    return quickView;
}

@end
