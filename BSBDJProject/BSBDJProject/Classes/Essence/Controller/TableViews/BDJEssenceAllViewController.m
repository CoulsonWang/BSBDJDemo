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
#import "BDJEssenceTopicCell.h"

static NSString *const topicCellID = @"topicCellID";

@interface BDJEssenceAllViewController ()

@property (strong, nonatomic) NSMutableArray *topicItems;
@property (strong, nonatomic) BDJTopicUserInfoItem *userInfoItem;
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation BDJEssenceAllViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJEssenceTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellID];
    
    self.tableView.rowHeight = 200;
}

/**
 处理下拉刷新数据
 */
- (void)refreshData {
    //先取消进行中的任务并重置视图
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSDictionary *params = @{
                             @"a" : @"list",
                             @"c" : @"data",
                             @"type" : [NSNumber numberWithUnsignedInteger:BDJTopicTypeAll]
                             };
    
    [self.manager GET:CommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        self.topicItems = [BDJEssenceTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.userInfoItem = [BDJTopicUserInfoItem mj_objectWithKeyValues:responseObject[@"info"]];
        
        [self.tableView reloadData];
        self.headerRefreshing = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SVProgressHUD.minimumDismissTimeInterval = 2;
        if (error.code != -999) {
            [SVProgressHUD showErrorWithStatus:@"数据加载失败!请稍后重试"];
        }
        self.headerRefreshing = NO;
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
                             @"type" : @1,
                             @"maxtime" : self.userInfoItem.maxtime
                             };
    
    [self.manager GET:CommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        AFNWriteToPlist(test)
        self.userInfoItem = [BDJTopicUserInfoItem mj_objectWithKeyValues:responseObject[@"info"]];
        NSArray *moreTopics = [BDJEssenceTopicItem mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicItems addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        self.footerLoading = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != -999) {
            [SVProgressHUD showErrorWithStatus:@"数据加载失败!请稍后重试"];
        }
        self.footerLoading = NO;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footer.hidden = (self.topicItems.count == 0);
    return self.topicItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellID];
    
    BDJEssenceTopicItem *item = self.topicItems[indexPath.row];
    cell.item = item;
    
    return cell;
}



@end
