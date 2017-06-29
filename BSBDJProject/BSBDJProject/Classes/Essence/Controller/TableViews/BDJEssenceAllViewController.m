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

@interface BDJEssenceAllViewController ()

@end

@implementation BDJEssenceAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)refreshData {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{
                             @"a" : @"list",
                             @"c" : @"data",
                             @"type" : @1
                             };
    
    [mgr GET:CommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        AFNWriteToPlist(all)
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}




@end
