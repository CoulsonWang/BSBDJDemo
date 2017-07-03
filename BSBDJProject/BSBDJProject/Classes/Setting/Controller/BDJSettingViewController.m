//
//  BDJSettingViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJSettingViewController.h"
#import <SVProgressHUD.h>
#import "CacheTool.h"

static NSString *const cellID = @"cellID";
#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface BDJSettingViewController ()

@property (assign, nonatomic) NSInteger totalSize;

@end

@implementation BDJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [SVProgressHUD showWithStatus:@"正在计算缓存大小"];
    [CacheTool getFileSize:cachePath completion:^(NSInteger totalSize) {
        self.totalSize = totalSize;
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    NSString *sizeString = [CacheTool getSizeString:self.totalSize];
    cell.textLabel.text = [NSString stringWithFormat:@"清理缓存(%@)",sizeString];
    return cell;
}

//点击时清除缓存
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [CacheTool removeFileOfDirectory:cachePath];
    self.totalSize = 0;
    SVProgressHUD.minimumDismissTimeInterval = 2.0;
    [SVProgressHUD showSuccessWithStatus:@"缓存已清理"];
    [self.tableView reloadData];
}




@end
