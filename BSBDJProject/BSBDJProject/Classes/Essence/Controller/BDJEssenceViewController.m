//
//  BDJEssenceViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceViewController.h"
#import "UIBarButtonItem+CreateItem.h"

@interface BDJEssenceViewController ()

@end

@implementation BDJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    
    [self setUpScrollView];
    
    [self setUpTitlesView];
}



/**
 设置导航条
 */
- (void)setUpNavigationBar {
    //通过调用分类中的类方法快速创建UIBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highLightImage:[UIImage imageNamed:@"nav_item_game_click_icon"]target:self action:@selector(leftNavBtnClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highLightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(rightNavBtnClick)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}



- (void)setUpScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
}

- (void)setUpTitlesView {
    UIView *titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.YY_width, 44)];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titlesView];
}

/**
 处理左侧导航条按钮点击事件
 */
- (void)leftNavBtnClick {

}
/**
 处理右侧导航条按钮点击事件
 */
- (void)rightNavBtnClick {

}

@end
