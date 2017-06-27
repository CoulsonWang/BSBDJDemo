//
//  BDJFriendTrendViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJFriendTrendViewController.h"
#import "UIBarButtonItem+CreateItem.h"
#import "BDJLoginRegisterViewController.h"

@interface BDJFriendTrendViewController ()

@end

@implementation BDJFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 设置导航条
 */
- (void)setUpNavigationBar {
    //通过调用分类中的类方法快速创建UIBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highLightImage:nil target:self action:@selector(leftNavBtnClick)];
    self.navigationItem.title = @"我的关注";
}



/**
 处理左侧导航条按钮点击事件
 */
- (void)leftNavBtnClick {
    
}

- (IBAction)loginButtonClick:(UIButton *)sender {
    BDJLoginRegisterViewController *loginVC = [[BDJLoginRegisterViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


@end
