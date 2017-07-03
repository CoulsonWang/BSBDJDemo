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
#import "BDJWebViewController.h"


static NSString *const cellID = @"cellID";
static NSInteger const colums = 4;
static CGFloat const margin = 1;
#define itemWH ((screenW - (colums - 1)* margin) / colums)

@interface BDJMineViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *squareItems;
@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation BDJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    
    [self setUpFootView];
    
    [self loadData];
    
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
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

    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);
    flowLayout.minimumLineSpacing = margin;
    flowLayout.minimumInteritemSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 1000) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
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
    
    [mgr GET:CommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        NSArray *dictArr = responseObject[@"square_list"];
        self.squareItems= [BDJSquareItem mj_objectArrayWithKeyValuesArray:dictArr];
        NSInteger rows = (self.squareItems.count - 1) / colums + 1;
        self.collectionView.YY_height = rows * itemWH;
        self.tableView.tableFooterView = self.collectionView;
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


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BDJSquareItem *item = self.squareItems[indexPath.item];
    if (![item.url containsString:@"http"]) return;
    
    BDJWebViewController *webVC = [[BDJWebViewController alloc] init];
    webVC.url = [NSURL URLWithString:item.url];
    [self.navigationController showViewController:webVC sender:nil];
}


@end
