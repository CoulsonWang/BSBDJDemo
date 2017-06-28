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
    
    self.tableView.scrollsToTop = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",NSStringFromClass([tableView class]),indexPath.row];
    
    return cell;
}


@end
