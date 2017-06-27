//
//  BDJLoginRegisterViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJLoginRegisterViewController.h"
#import "BDJLogginRegistView.h"
#import "BDJQuickLoginView.h"

@interface BDJLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middelView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewConstraint;

@end

@implementation BDJLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BDJLogginRegistView *loginView = [BDJLogginRegistView loginView];
    [self.middelView addSubview:loginView];
    
    BDJQuickLoginView *quickLoginView = [BDJQuickLoginView quickLoginView];
    [self.bottomView addSubview:quickLoginView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    for (UIView *view in self.middelView.subviews) {
        view.YY_width = self.middelView.YY_width * 0.5;
    }
    
    self.bottomView.subviews.lastObject.bounds = self.bottomView.bounds;
}


- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)registerBtnClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BDJLogginRegistView *registView = [BDJLogginRegistView registView];
        registView.YY_x = self.middelView.YY_width * 0.5;
        [self.middelView addSubview:registView];
    });
    _middleViewConstraint.constant = _middleViewConstraint.constant == 0 ? -self.middelView.YY_width * 0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
