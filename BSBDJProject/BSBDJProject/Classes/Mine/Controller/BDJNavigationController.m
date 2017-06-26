//
//  BDJNavigationController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJNavigationController.h"
#import "UIBarButtonItem+CreateItem.h"

@interface BDJNavigationController ()

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
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highLightImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(getBack) title:@"返回"];
    }
    [super pushViewController:viewController animated:animated];
    
}

- (void)getBack {
    [self popViewControllerAnimated:YES];
}




@end
