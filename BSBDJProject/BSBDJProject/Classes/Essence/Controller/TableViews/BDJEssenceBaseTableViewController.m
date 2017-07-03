//
//  BDJEssenceBaseTableViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/28.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceBaseTableViewController.h"
#import <AFNetworking.h>
#import <SDImageCache.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import "UIColor+RGB.h"
#import "BDJEssenceTopicItem.h"
#import "BDJTopicUserInfoItem.h"
#import "BDJEssenceTopicCell.h"

static NSString *const topicCellID = @"topicCellID";

@interface BDJEssenceBaseTableViewController ()



- (BDJTopicType)topicType;

@end

@implementation BDJEssenceBaseTableViewController

- (BDJTopicUserInfoItem *)userInfoItem {
    if (!_userInfoItem) {
        _userInfoItem = [[BDJTopicUserInfoItem alloc] init];
    }
    return _userInfoItem;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (BDJTopicType)topicType {
    return 0;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(NavigationBarHeight + TitleHeight, 0, TabBarHeight, 0);
    self.tableView.scrollsToTop = NO;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = [UIColor colorWithR:206 G:206 B:206];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJEssenceTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:BDJTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClcik) name:BDJTitleButtonDidRepeatClickNotification object:nil];
    
    [self setUpFooter];
    
    [self setUpHeader];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化设置


/**
 设置下拉刷新视图
 */
- (void)setUpHeader {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

/**
 设置上拉加载数据视图
 */
- (void)setUpFooter {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}



#pragma mark - 处理事件响应

/**
 处理tabBar按钮被重复点击
 */
- (void)tabBarButtonDidRepeatClick {
    //如果重复点击的不是精华按钮，则不处理
    if (self.view.window == nil) return;
    
    //如果当前tableView不在视图上，则不处理
    if (self.tableView.scrollsToTop == NO) return;
    
    [self.tableView.mj_header beginRefreshing];
}

/**
 处理标题按钮被重复点击
 */
- (void)titleButtonDidRepeatClcik {
    //如果当前tableView不在视图上，则不处理
    if (self.tableView.scrollsToTop == NO) return;
    
    [self.tableView.mj_header beginRefreshing];
}




#pragma mark - 处理下拉刷新和上拉加载

/**
 处理下拉刷新数据
 */
- (void)refreshData {
    //先取消进行中的任务并重置视图
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSDictionary *params = @{
                             @"a" : @"list",
                             @"c" : @"data",
                             @"type" : @(self.topicType)
                             };
    
    [self.manager GET:CommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        self.topicItems = [BDJEssenceTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.userInfoItem = [BDJTopicUserInfoItem mj_objectWithKeyValues:responseObject[@"info"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SVProgressHUD.minimumDismissTimeInterval = 2;
        if (error.code != -999) {
            [SVProgressHUD showErrorWithStatus:@"数据加载失败!请稍后重试"];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 处理上拉加载数据
 */
- (void)loadMoreData {
    //先取消进行中的任务并重置视图
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSDictionary *params = @{
                             @"a" : @"list",
                             @"c" : @"data",
                             @"type" : @(self.topicType),
                             @"maxtime" :self.userInfoItem.maxtime
                             };
    
    [self.manager GET:CommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        AFNWriteToPlist(test)
        self.userInfoItem = [BDJTopicUserInfoItem mj_objectWithKeyValues:responseObject[@"info"]];
        NSArray *moreTopics = [BDJEssenceTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicItems addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != -999) {
            [SVProgressHUD showErrorWithStatus:@"数据加载失败!请稍后重试"];
        }
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    tableView.mj_footer.hidden = (self.topicItems.count == 0);
    return self.topicItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellID];
    
    BDJEssenceTopicItem *item = self.topicItems[indexPath.row];
    cell.item = item;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceTopicItem *item = self.topicItems[indexPath.row];
    return item.cellHeight;
}



@end
