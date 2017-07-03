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

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@property (strong, nonatomic) NSMutableArray<BDJEssenceTopicItem *> *topicItems;

@property (strong, nonatomic) BDJTopicUserInfoItem *userInfoItem;

@end
