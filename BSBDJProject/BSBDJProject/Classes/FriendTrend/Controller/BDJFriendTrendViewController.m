//
//  BDJFriendTrendViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJFriendTrendViewController.h"
#import "UIBarButtonItem+CreateItem.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/**
 设置导航条
 */
- (void)setUpNavigationBar {
    //通过调用分类中的类方法快速创建UIBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highLightImage:nil target:self action:@selector(leftNavBtnClick)];
    UILabel *titleLable = [[UILabel alloc] init];
    titleLable.text = @"我的关注";
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;
}



/**
 处理左侧导航条按钮点击事件
 */
- (void)leftNavBtnClick {
    
}



@end
