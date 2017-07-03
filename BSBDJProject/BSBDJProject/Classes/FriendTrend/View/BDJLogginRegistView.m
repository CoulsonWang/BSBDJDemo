//
//  BDJLogginRegistView.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJLogginRegistView.h"

@interface BDJLogginRegistView ()




@end

@implementation BDJLogginRegistView

+ (instancetype)loginView {
    BDJLogginRegistView *loginView = [self YY_viewFromNib];
    return loginView;
}

+ (instancetype)registView {
    BDJLogginRegistView *registView = [self YY_viewFromNib];
    return registView;
}

@end
