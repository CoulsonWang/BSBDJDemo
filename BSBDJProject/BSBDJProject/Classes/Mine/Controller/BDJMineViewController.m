//
//  BDJMineViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJMineViewController.h"
#import "UIBarButtonItem+CreateItem.h"
#import "BDJSettingViewController.h"
#import "BDJSquareCollectionViewCell.h"
#import "BDJSquareItem.h"
#import <AFNetworking.h>
#import <MJExtension.h>

static NSString *const cellID = @"cellID";

@interface BDJMineViewController () <UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *squareItems;
@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation BDJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    
    [self setUpFootView];
    
    [self loadData];
}



/**
 设置导航条
 */
- (void)setUpNavigationBar {
    //通过调用分类中的类方法快速创建UIBarButtonItem
    UIBarButtonItem *nightModeBtn = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] highLightImage:[UIImage imageNamed:@"mine-sun-icon-click"] selectedImage:[UIImage imageNamed:@"mine-sun-icon"] target:self action:@selector(nightModeBtnClick:)];
    UIBarButtonItem *settingBtn = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highLightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingBtnClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingBtn,nightModeBtn];
    
    self.navigationItem.title = @"我的";
}

/**
 设置底部滑块
 */
- (void)setUpFootView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    NSInteger colums = 4;
    CGFloat margin = 1;
    CGFloat itemW = (screenW - (colums - 1)*margin) / colums;
    CGFloat itemH = itemW * 1.0;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 1000) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJSquareCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
    self.tableView.tableFooterView = collectionView;
}

/**
 处理夜间模式按钮点击
 */
- (void)nightModeBtnClick:(UIButton *)btn {
    btn.selected = !btn.isSelected;
}

/**
 处理设置按钮点击
 */
- (void)settingBtnClick {
    BDJSettingViewController *settingVC = [[BDJSettingViewController alloc] init];
    [self.navigationController showViewController:settingVC sender:nil];
}

/**
 发送网络请求
 */
- (void)loadData {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{
                             @"a" : @"square",
                             @"c" : @"topic"
                             };
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        NSArray *dictArr = responseObject[@"square_list"];
        self.squareItems= [BDJSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDJSquareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.item = self.squareItems[indexPath.item];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.1;
            break;
        default:
            return 10;
            break;
    }
}

@end
