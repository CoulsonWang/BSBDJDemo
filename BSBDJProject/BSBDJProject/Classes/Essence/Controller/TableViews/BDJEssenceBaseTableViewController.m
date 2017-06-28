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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:BDJTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClcik) name:BDJTitleButtonDidRepeatClickNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

/**
 处理tabBar按钮被重复点击
 */
- (void)tabBarButtonDidRepeatClick {
    //如果重复点击的不是精华按钮，则不处理
    if (self.view.window == nil) return;
    
    //如果当前tableView不在视图上，则不处理
    if (self.tableView.scrollsToTop == NO) return;
    
    [self refreshView];
}

/**
 处理标题按钮被重复点击
 */
- (void)titleButtonDidRepeatClcik {
    //如果当前tableView不在视图上，则不处理
    if (self.tableView.scrollsToTop == NO) return;
    
    [self refreshView];
}

/**
 刷新界面
 */
- (void)refreshView {
    //子类重写该方法来刷新界面
    NSLog(@"%s,%d",__func__,__LINE__);
}


@end
