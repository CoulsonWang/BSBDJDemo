//
//  BDJSuggestTabController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

//请求URL头
#define urlPrefix @"http://api.budejie.com/api/api_open.php"
//广告请求参数名
#define requestKey_1 @"a"
#define requestKey_2 @"action"
#define requestKey_3 @"c"
//广告请求参数
#define requestParameter_1 @"tag_recommend"
#define requestParameter_2 @"sub"
#define requestParameter_3 @"topic"

#import "BDJSuggestTabController.h"
#import "BDJSuggestTapItem.h"
#import "BDJSuggestTagCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

static NSString *const cellID = @"cellID";

@interface BDJSuggestTabController ()

@property (nonatomic, strong) NSArray *suggestTagItems;
@property (strong, nonatomic) AFHTTPSessionManager *mgr;

@end

@implementation BDJSuggestTabController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐标签";
    [self getData];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJSuggestTagCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    //取消掉所有正在进行的网络请求
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

#pragma mark - 请求数据
- (void)getData {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    self.mgr = mgr;
    
    NSDictionary *params = @{
                             requestKey_1 : requestParameter_1,
                             requestKey_2 : requestParameter_2,
                             requestKey_3 : requestParameter_3
                             };
    
    [mgr GET:urlPrefix parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *_Nullable responseObject) {
        [SVProgressHUD dismiss];
         self.suggestTagItems = [BDJSuggestTapItem mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.suggestTagItems.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJSuggestTagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    BDJSuggestTapItem *item = self.suggestTagItems[indexPath.row];
    cell.item = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


@end
