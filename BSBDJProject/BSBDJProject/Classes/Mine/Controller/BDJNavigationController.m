//
//  BDJNavigationController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJNavigationController.h"
#import "UIBarButtonItem+CreateItem.h"

@interface BDJNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation BDJNavigationController

+ (void)load {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    navBar.titleTextAttributes = @{
                                   NSFontAttributeName : [UIFont boldSystemFontOfSize:20]
                                   };
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //如果不是根控制器，则设置左侧导航按钮为返回按钮
    if (self.childViewControllers.count) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highLightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(getBack) title:@"返回"];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)getBack {
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
//控制滑动返回操作什么时候触发
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //如果非根控制器则触发，根控制器则禁用
    return self.childViewControllers.count > 1;
}



@end
