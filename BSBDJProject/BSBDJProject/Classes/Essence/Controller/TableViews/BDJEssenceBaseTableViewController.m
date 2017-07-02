//
//  BDJEssenceBaseTableViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/28.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceBaseTableViewController.h"
#import "BDJEssenceRefreshHeaderView.h"
#import "UIColor+RGB.h"
#import <AFNetworking.h>
#import <SDImageCache.h>
#import "BDJEssenceTopicItem.h"
#import "BDJTopicUserInfoItem.h"
#import "BDJEssenceTopicCell.h"

static NSString *const topicCellID = @"topicCellID";

@interface BDJEssenceBaseTableViewController ()

@property (weak, nonatomic) UILabel *footerLabel;
@property (weak, nonatomic) BDJEssenceRefreshHeaderView *header;
@property (weak, nonatomic) UILabel *headerLabel;




@end

@implementation BDJEssenceBaseTableViewController

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
    
    self.tableView.contentInset = UIEdgeInsetsMake(NavigationBarHeight + TitleHeight, 0, TabBarHeight, 0);
    self.tableView.scrollsToTop = NO;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = [UIColor colorWithR:206 G:206 B:206];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJEssenceTopicCell class]) bundle:nil] forCellReuseIdentifier:topicCellID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:BDJTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClcik) name:BDJTitleButtonDidRepeatClickNotification object:nil];
    
    [self setUpFooter];
    
    [self setUpHeader];
    
    [self headerRefreshBegin];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.header.YY_height = 44;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化设置

/**
 设置上拉加载数据视图
 */
- (void)setUpFooter {
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.YY_width, 35);
    footer.backgroundColor = [UIColor colorWithR:206 G:206 B:206];
    self.footer = footer;
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.frame = footer.bounds;
    footerLabel.text = @"上拉加载更多";
    footerLabel.textColor = [UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLabel];
    self.footerLabel = footerLabel;
    
    self.tableView.tableFooterView = footer;
}

/**
 设置下拉刷新视图
 */
- (void)setUpHeader {
    
    BDJEssenceRefreshHeaderView *header = [BDJEssenceRefreshHeaderView refreshHeader];
    header.frame = CGRectMake(0, -RefreshHeaderHeight, self.tableView.YY_width, RefreshHeaderHeight);
    header.titleLabel.text = @"下拉刷新";
    self.header = header;
    
    [self.tableView addSubview:header];
}


#pragma mark - 处理事件响应

/**
 处理tabBar按钮被重复点击
 */
- (void)tabBarButtonDidRepeatClick {
    //如果重复点击的不是精华按钮，则不处理
    if (self.view.window == nil) return;
    
    //如果当前tableView不在视图上，则不处理
    if (self.tableView.scrollsToTop == NO) return;
    
    [self refreshView];
}

/**
 处理标题按钮被重复点击
 */
- (void)titleButtonDidRepeatClcik {
    //如果当前tableView不在视图上，则不处理
    if (self.tableView.scrollsToTop == NO) return;
    
    [self refreshView];
}

/**
 刷新界面
 */
- (void)refreshView {
    [self headerRefreshBegin];
}



#pragma mark - 处理下拉刷新和上拉加载
/**
 处理上拉加载数据
 */
- (void)loadMoreData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.footerLoading = NO;
    });
}

/**
 处理下拉刷新数据
 */
- (void)refreshData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    self.headerRefreshing = NO;
    });
}

/**
 加载状态发生变化时更新UI界面
 */
- (void)setFooterLoading:(BOOL)footerLoading {
    _footerLoading = footerLoading;
    //处理footer控件页面表现
    if (footerLoading) {
        //处理正在加载数据时的表现
        self.footerLabel.text = @"正在加载更多数据...";
    } else {
        //处理加载完毕时的表现
        self.footerLabel.text = @"上拉加载更多";
    }
}

/**
 刷新状态发生变化时更新UI界面
 */
- (void)setHeaderRefreshing:(BOOL)headerRefreshing {
    _headerRefreshing = headerRefreshing;
    if (headerRefreshing) {
        self.header.titleLabel.text = @"正在刷新...";
        self.tableView.contentInset = UIEdgeInsetsMake(NavigationBarHeight+TitleHeight+RefreshHeaderHeight, 0, self.tableView.contentInset.bottom, 0);
        
        CGPoint offset = self.tableView.contentOffset;
        offset.y = -(self.tableView.contentInset.top);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableView.contentOffset = offset;
        }];
        
        
    } else {
        self.header.titleLabel.text = @"下拉刷新";
        [UIView animateWithDuration:0.35 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(NavigationBarHeight+TitleHeight, 0, self.tableView.contentInset.bottom, 0);
        }];
    }
}




- (void)dealWithFooter {
    if (self.isLoading) return;
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.YY_height;
    if (self.tableView.contentSize.height != 0 && self.tableView.contentOffset.y >= offsetY) {
        self.footerLoading = YES;
        [self loadMoreData];
        
    }
}

- (void)dealWithHeader {
    if (self.isRefreshing) return;
    
    CGFloat offsetY = - (NavigationBarHeight + TitleHeight + RefreshHeaderHeight);
    
    if (self.tableView.contentOffset.y <= offsetY) {
        self.header.titleLabel.text = @"松开立即刷新";
    } else {
        self.header.titleLabel.text = @"下拉刷新";
    }
}

- (void)headerRefreshBegin {
    self.headerRefreshing = YES;
    [self refreshData];
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

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceTopicItem *item = self.topicItems[indexPath.row];
    return item.cellHeight;
}

#pragma mark - UIScrollViewDelegate 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //处理上拉加载
    [self dealWithFooter];
    
    //处理下拉刷新
    [self dealWithHeader];
    

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.isRefreshing) return;
    
    CGFloat offsetY = - (NavigationBarHeight + TitleHeight + RefreshHeaderHeight);
    if (scrollView.contentOffset.y <= offsetY) {
        [self headerRefreshBegin];
    }
}



@end
