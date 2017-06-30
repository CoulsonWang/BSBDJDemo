//
//  BDJEssenceBaseTableViewController.h
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/28.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AFHTTPSessionManager;
@class BDJEssenceTopicItem;
@class BDJTopicUserInfoItem;

@interface BDJEssenceBaseTableViewController : UITableViewController

/** 是否正在加载 */
@property (assign, nonatomic, getter=isLoading) BOOL footerLoading;
/** 是否正在刷新 */
@property (assign, nonatomic, getter=isRefreshing) BOOL headerRefreshing;

@property (weak, nonatomic) UIView *footer;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@property (strong, nonatomic) NSMutableArray<BDJEssenceTopicItem *> *topicItems;

@property (strong, nonatomic) BDJTopicUserInfoItem *userInfoItem;

@end
