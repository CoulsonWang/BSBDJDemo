//
//  BDJEssenceAllViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/28.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceAllViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "BDJEssenceTopicItem.h"
#import "BDJTopicUserInfoItem.h"

@interface BDJEssenceAllViewController ()

@property (strong, nonatomic) NSMutableArray *topicItems;
@property (strong, nonatomic) BDJTopicUserInfoItem *userInfoItem;

@end

@implementation BDJEssenceAllViewController

- (BDJTopicUserInfoItem *)userInfoItem {
    if (!_userInfoItem) {
        _userInfoItem = [[BDJTopicUserInfoItem alloc] init];
    }
    return _userInfoItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 处理下拉刷新数据
 */
- (void)refreshData {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{
                             @"a" : @"list",
                             @"c" : @"data",
                             @"type" : @1
                             };
    
    [mgr GET:CommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        self.topicItems = [BDJEssenceTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.userInfoItem = [BDJTopicUserInfoItem mj_objectWithKeyValues:responseObject[@"info"]];
        
        [self.tableView reloadData];
        self.headerRefreshing = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SVProgressHUD.minimumDismissTimeInterval = 2;
        [SVProgressHUD showErrorWithStatus:@"数据获取失败!请稍后重试"];
        self.headerRefreshing = NO;
    }];
}

/**
 处理上拉加载数据
 */
- (void)loadMoreData {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{
                             @"a" : @"list",
                             @"c" : @"data",
                             @"type" : @1,
                             @"maxtime" : self.userInfoItem.maxtime
                             };
    
    [mgr GET:CommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        AFNWriteToPlist(test)
        self.userInfoItem = [BDJTopicUserInfoItem mj_objectWithKeyValues:responseObject[@"info"]];
        NSArray *moreTopics = [BDJEssenceTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicItems addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        self.footerLoading = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"数据加载失败!请稍后重试"];
        self.footerLoading = NO;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    BDJEssenceTopicItem *item = self.topicItems[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.text;
    
    return cell;
}



@end
