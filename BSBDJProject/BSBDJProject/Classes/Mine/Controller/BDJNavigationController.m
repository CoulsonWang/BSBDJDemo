//
//  BDJNavigationController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJNavigationController.h"

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





@end
