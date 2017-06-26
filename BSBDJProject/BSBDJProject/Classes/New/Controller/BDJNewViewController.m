//
//  BDJNewViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJNewViewController.h"
#import "UIBarButtonItem+CreateItem.h"
#import "BDJSuggestTabController.h"

@interface BDJNewViewController ()

@end

@implementation BDJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highLightImage:[UIImage imageWithOriginalRenderMode:@"MainTagSubIconClick"] target:self action:@selector(leftNavBtnClick)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}



/**
 处理左侧导航条按钮点击事件
 */
- (void)leftNavBtnClick {
    BDJSuggestTabController *suggestVC = [[BDJSuggestTabController alloc] init];
    [self.navigationController pushViewController:suggestVC animated:YES];
}

@end
