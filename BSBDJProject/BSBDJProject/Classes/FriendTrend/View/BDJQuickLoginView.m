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
    BDJQuickLoginView *quickView = [self YY_viewFromNib];
    
    return quickView;
}

@end
