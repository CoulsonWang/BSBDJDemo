//
//  BDJEssencePhotoViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/28.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssencePhotoViewController.h"
#import "BDJEssenceTopicCell.h"
#import "BDJEssenceTopicItem.h"
#import "BDJTopicUserInfoItem.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>

@interface BDJEssencePhotoViewController ()

@end

@implementation BDJEssencePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
                             @"type" : [NSNumber numberWithUnsignedInteger:BDJTopicTypePhoto]
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
                             @"type" : [NSNumber numberWithUnsignedInteger:BDJTopicTypePhoto],
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



@end
