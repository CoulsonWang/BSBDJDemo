//
//  BDJEssenceBaseTableViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/28.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceBaseTableViewController.h"

@interface BDJEssenceBaseTableViewController ()

@end

@implementation BDJEssenceBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat topInset = NavigationBarHeight + TitleHeight;
    CGFloat bottomInset = TabBarHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
}



@end
