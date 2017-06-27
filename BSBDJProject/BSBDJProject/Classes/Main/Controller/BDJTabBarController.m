//
//  BDJTabBarController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJTabBarController.h"
#import "BDJNewViewController.h"
#import "BDJMineViewController.h"
#import "BDJEssenceViewController.h"
#import "BDJPublishViewController.h"
#import "BDJFriendTrendViewController.h"
#import "BDJNavigationController.h"
#import "BDJTaBbar.h"

@interface BDJTabBarController ()

@end

@implementation BDJTabBarController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBar];
    
    [self setUpAllChildViewController];
    
    [self setUpAllBarButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 初始化设置
/**
 设置子控制器
 */
- (void)setUpAllChildViewController {
    //精华
    BDJEssenceViewController *essenceVC = [[BDJEssenceViewController alloc] init];
    BDJNavigationController *nav1 = [[BDJNavigationController alloc] initWithRootViewController:essenceVC];
    [self addChildViewController:nav1];
    
    //新帖
    BDJNewViewController *newVC = [[BDJNewViewController alloc] init];
    BDJNavigationController *nav2 = [[BDJNavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:nav2];
    
    
    //关注
    BDJFriendTrendViewController *friendTrendVC = [[BDJFriendTrendViewController alloc] init];
    BDJNavigationController *nav4 = [[BDJNavigationController alloc] initWithRootViewController:friendTrendVC];
    [self addChildViewController:nav4];
    
    //我的
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([BDJMineViewController class]) bundle:nil];
    BDJMineViewController *mineVC = [storyboard instantiateInitialViewController];
    BDJNavigationController *nav5 = [[BDJNavigationController alloc] initWithRootViewController:mineVC];
    [self addChildViewController:nav5];
}

/**
 设置按钮
 */
- (void)setUpAllBarButton {
    [self setUpOneBarButton:self.childViewControllers[0] title:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    
    [self setUpOneBarButton:self.childViewControllers[1] title:@"新帖" image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    
    [self setUpOneBarButton:self.childViewControllers[2] title:@"关注" image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];
    
    [self setUpOneBarButton:self.childViewControllers[3] title:@"我的" image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
}

- (void)setUpOneBarButton:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    //设置标题
    vc.tabBarItem.title = title;
    //处理标题字体和字色
    NSDictionary *attrs_selected = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    NSDictionary *attrs_normal = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    [vc.tabBarItem setTitleTextAttributes:attrs_normal forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:attrs_selected forState:UIControlStateSelected];
    //设置按钮图片
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 用自定义的TabBar替换系统的TabBar
 */
- (void)setUpTabBar {
    BDJTaBbar *tabBar = [[BDJTaBbar alloc] init];
    
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

@end
