//
//  BDJEssenceBaseTableViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/28.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceBaseTableViewController.h"

@interface BDJEssenceBaseTableViewController ()

@property (weak, nonatomic) UIView *footer;
@property (weak, nonatomic) UILabel *footerLabel;
/** 是否正在刷新 */
@property (assign, nonatomic, getter=isRefreshing) BOOL footerRefreshing;

@end

@implementation BDJEssenceBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(NavigationBarHeight + TitleHeight, 0, TabBarHeight, 0);
    self.tableView.scrollsToTop = NO;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:BDJTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClcik) name:BDJTitleButtonDidRepeatClickNotification object:nil];
    
    [self setUpFooter];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化设置

- (void)setUpFooter {
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, self.tableView.YY_width, 35);
    footer.backgroundColor = [UIColor darkGrayColor];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",NSStringFromClass([tableView class]),indexPath.row];
    
    return cell;
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
    //子类重写该方法来刷新界面
    NSLog(@"%s,%d",__func__,__LINE__);
}


/**
 处理上拉加载数据
 */
- (void)loadMoreData {
    //处理界面表现
    
}

- (void)setFooterRefreshing:(BOOL)footerRefreshing {
    _footerRefreshing = footerRefreshing;
    //处理footer控件页面表现
    if (footerRefreshing) {
        //处理正在加载数据时的表现
        self.footerLabel.text = @"正在加载更多数据...";
    } else {
        //处理加载完毕时的表现
        self.footerLabel.text = @"上拉加载更多";
    }
}

#pragma mark - UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isRefreshing) return;
    
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.YY_height;
    if (self.tableView.contentSize.height != 0 && scrollView.contentOffset.y >= offsetY) {
        self.footerRefreshing = YES;
        [self loadMoreData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.footerRefreshing = NO;
        });
    }
}

@end
