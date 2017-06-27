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
    BDJLogginRegistView *loginView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    return loginView;
}

+ (instancetype)registView {
    BDJLogginRegistView *registView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    return registView;
}

@end
