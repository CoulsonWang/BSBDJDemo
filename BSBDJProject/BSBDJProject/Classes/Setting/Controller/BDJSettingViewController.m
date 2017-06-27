//
//  BDJSettingViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJSettingViewController.h"
#import <SVProgressHUD.h>

static NSString *const cellID = @"cellID";
#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface BDJSettingViewController ()

@end

@implementation BDJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    NSInteger totalSize = [self getFileSize:cachePath];
    cell.textLabel.text = [self getSizeString:totalSize];
    
    return cell;
}

//点击时清除缓存
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *filepathes = [mgr contentsOfDirectoryAtPath:cachePath error:nil];
    for (NSString *filepath in filepathes) {
        NSString *path = [cachePath stringByAppendingPathComponent:filepath];
        [mgr removeItemAtPath:path error:nil];
    }
    SVProgressHUD.minimumDismissTimeInterval = 2.0;
    [SVProgressHUD showSuccessWithStatus:@"缓存清理成功"];
    [self.tableView reloadData];
}

//计算缓存大小
- (NSInteger)getFileSize:(NSString *)directoryPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    NSArray *pathArray = [mgr subpathsAtPath:directoryPath];
    NSInteger totalSize = 0;
    for (NSString *path in pathArray) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:path];
        if ([filePath containsString:@".DS"]) continue;
        BOOL isDirectory;
        BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (isDirectory || !isExist) continue;
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        NSInteger fileSize = [attr fileSize];
        totalSize += fileSize;
    }
    return totalSize;
}

//通过缓存Byte计算大小
-(NSString *)getSizeString:(NSInteger)totalSize {
    NSString *sizeStr;
    if (totalSize >= 1000 * 1000) {
        sizeStr = [NSString stringWithFormat:@"%.1fMB",totalSize / 1000.0 / 1000.0];
    } else if (totalSize >= 1000) {
        sizeStr = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000.0];
    } else {
        sizeStr = [NSString stringWithFormat:@"%ldB",totalSize];
    }
    NSString *sizeString = [NSString stringWithFormat:@"清楚缓存(%@)",sizeStr];
    return sizeString;
}

@end
