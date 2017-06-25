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

@interface BDJTabBarController ()

@end

@implementation BDJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildViewController];
    
    [self setUpAllBarButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 初始化设置
- (void)setUpAllChildViewController {
    //精华
    BDJEssenceViewController *essenceVC = [[BDJEssenceViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:essenceVC];
    [self addChildViewController:nav1];
    
    //新帖
    BDJNewViewController *newVC = [[BDJNewViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:newVC];
    [self addChildViewController:nav2];
    
    //发布
    BDJPublishViewController *publishVC = [[BDJPublishViewController alloc] init];
    [self addChildViewController:publishVC];
    
    //关注
    BDJFriendTrendViewController *friendTrendVC = [[BDJFriendTrendViewController alloc] init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:friendTrendVC];
    [self addChildViewController:nav4];
    
    //我的
    BDJMineViewController *mineVC = [[BDJMineViewController alloc] init];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:mineVC];
    [self addChildViewController:nav5];
}

- (void)setUpAllBarButton {
    [self setUpOneBarButton:self.childViewControllers[0] title:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    
    [self setUpOneBarButton:self.childViewControllers[1] title:@"新帖" image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    
    [self setUpOneBarButton:self.childViewControllers[2] title:nil image:[UIImage imageNamed:@"tabBar_publish_icon"] selectedImage:[UIImage imageNamed:@"tabBar_publish_click_icon"]];
    
    [self setUpOneBarButton:self.childViewControllers[3] title:@"关注" image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];
    
    [self setUpOneBarButton:self.childViewControllers[4] title:@"我的" image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
}

- (void)setUpOneBarButton:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
