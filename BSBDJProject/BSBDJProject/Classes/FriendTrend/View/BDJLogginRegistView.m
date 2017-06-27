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
    NSDictionary *attrs = @{
                            NSForegroundColorAttributeName:[UIColor lightGrayColor],
                            NSFontAttributeName:[UIFont systemFontOfSize:15]
                            };
    [loginView.accountTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs]];
    [loginView.passwordTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"密码" attributes:attrs]];
    return loginView;
}

+ (instancetype)registView {
    BDJLogginRegistView *registView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    NSDictionary *attrs = @{
                            NSForegroundColorAttributeName:[UIColor lightGrayColor],
                            NSFontAttributeName:[UIFont systemFontOfSize:15]
                            };
    [registView.accountTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:attrs]];
    [registView.passwordTextField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"设置密码" attributes:attrs]];
    return registView;
}

@end
