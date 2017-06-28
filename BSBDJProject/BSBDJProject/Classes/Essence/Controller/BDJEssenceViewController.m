//
//  BDJEssenceViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceViewController.h"
#import "UIBarButtonItem+CreateItem.h"
#import "BDJEssenceTitleButton.h"
#import "BDJEssenceAllViewController.h"
#import "BDJEssenceVideoViewController.h"
#import "BDJEssenceSoundViewController.h"
#import "BDJEssencePhotoViewController.h"
#import "BDJEssenceCrossTalkViewController.h"

#define titles @[@"全部",@"视频",@"声音",@"图片",@"段子"]
#define titleCount titles.count

@interface BDJEssenceViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) UIView *titlesView;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) BDJEssenceTitleButton *selectedTitleButton;
@property (weak, nonatomic) UIView *titleUnderlineView;
@property (weak, nonatomic) UITableView *onScreenTableView;

@end

@implementation BDJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildViewController];
    
    [self setUpNavigationBar];
    
    [self setUpScrollView];
    
    [self setUpTitlesView];
    
    [self setUpFirstTableView];
}

#pragma mark - 初始化设置
/**
 设置导航条
 */
- (void)setUpNavigationBar {
    //通过调用分类中的类方法快速创建UIBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highLightImage:[UIImage imageNamed:@"nav_item_game_click_icon"]target:self action:@selector(leftNavBtnClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highLightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(rightNavBtnClick)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (void)setUpAllChildViewController {
    [self addChildViewController:[[BDJEssenceAllViewController alloc] init]];
    [self addChildViewController:[[BDJEssenceVideoViewController alloc] init]];
    [self addChildViewController:[[BDJEssenceSoundViewController alloc] init]];
    [self addChildViewController:[[BDJEssencePhotoViewController alloc] init]];
    [self addChildViewController:[[BDJEssenceCrossTalkViewController alloc] init]];
}

/**
 设置主滚动视图
 */
- (void)setUpScrollView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    CGFloat scrollViewWidth = scrollView.YY_width;
    
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollViewWidth, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.scrollsToTop = NO;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

/**
 初始化第一个tableView
 */
- (void)setUpFirstTableView {
    [self addChildViewControllerView:0];
    
    UITableView *firstView = (UITableView *)self.childViewControllers[0].view;
    firstView.scrollsToTop = YES;
    self.onScreenTableView = firstView;
}

/**
 设置标题视图
 */
- (void)setUpTitlesView {
    UIView *titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.YY_width, TitleHeight)];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    [self setUpTitleButtons];
    [self setUpTitleUnderline];
}

/**
 设置标题按钮
 */
- (void)setUpTitleButtons {
    
    CGFloat titleWidth = self.titlesView.YY_width / titleCount;
    CGFloat titleHeight = self.titlesView.YY_height;
    
    for (int i = 0; i < titleCount; i++) {
        BDJEssenceTitleButton *titleButton = [BDJEssenceTitleButton buttonWithType:UIButtonTypeCustom];
        [self.titlesView addSubview:titleButton];
        titleButton.frame = CGRectMake(i * titleWidth, 0, titleWidth, titleHeight);
        titleButton.tag = i;
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


/**
 设置标题中的下划线
 */
- (void)setUpTitleUnderline {
    UIView *titleUnderlineView = [[UIView alloc] init];
    self.titleUnderlineView = titleUnderlineView;
    CGFloat underlineHeight = 2;
    CGFloat underlineY = self.titlesView.YY_height - underlineHeight;
    CGFloat underlineWidth = 70;
    CGFloat underlineX = 0;
    BDJEssenceTitleButton *firstTitleBtn = self.titlesView.subviews.firstObject;
    titleUnderlineView.backgroundColor = [firstTitleBtn titleColorForState:UIControlStateSelected];
    
    titleUnderlineView.frame = CGRectMake(underlineX, underlineY, underlineWidth, underlineHeight);
    [self.titlesView addSubview:titleUnderlineView];
    
    //一开始就选中首个标题
    firstTitleBtn.selected = YES;
    self.selectedTitleButton = firstTitleBtn;
    [firstTitleBtn.titleLabel sizeToFit];
    CGFloat titleWidth = firstTitleBtn.titleLabel.YY_width + 10;
    self.titleUnderlineView.YY_width = titleWidth;
    self.titleUnderlineView.YY_centerX = firstTitleBtn.YY_centerX;
}


#pragma mark - 响应事件
/**
 处理标题按钮点击
 */
- (void)titleButtonClick:(BDJEssenceTitleButton *)btn {
    if (self.selectedTitleButton == btn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BDJTitleButtonDidRepeatClickNotification object:nil];
    }
    
    self.selectedTitleButton.selected = NO;
    btn.selected = YES;
    self.selectedTitleButton = btn;
    
    //计算文字宽度
    CGFloat titleWidth = btn.titleLabel.YY_width;
    NSInteger index = btn.tag;
    //更新下划线的宽度，并移动下划线
    [UIView animateWithDuration:0.2 animations:^{
        self.titleUnderlineView.YY_width = titleWidth + 10;
        self.titleUnderlineView.YY_centerX = btn.YY_centerX;
        
        //滚动scrollView
        self.scrollView.contentOffset = CGPointMake(index * self.scrollView.YY_width, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildViewControllerView:index];
        [self changeTableViewStatue:index];
    }];
}

/**
 添加子控制器视图

 @param childControllerIndex 控制器索引
 */
- (void)addChildViewControllerView:(NSInteger)childControllerIndex {
    UITableView *childView = (UITableView *)self.childViewControllers[childControllerIndex].view;
    if (childView.superview) return;
    childView.frame = CGRectMake(childControllerIndex * self.scrollView.YY_width, 0, self.scrollView.YY_width, self.scrollView.YY_height);
    [self.scrollView addSubview:childView];
}

/**
 修改tableView是否可通过点击状态栏滚动到顶部

 @param index 控制器索引
 */
- (void)changeTableViewStatue:(NSInteger)index {
    UITableView *childView = (UITableView *)self.childViewControllers[index].view;
    self.onScreenTableView.scrollsToTop = NO;
    childView.scrollsToTop = YES;
    self.onScreenTableView = childView;
}

/**
 处理左侧导航条按钮点击事件
 */
- (void)leftNavBtnClick {

}
/**
 处理右侧导航条按钮点击事件
 */
- (void)rightNavBtnClick {

}

#pragma mark - UIScrollViewDelegate

/**
 监听滚动，停止滚动后点击按钮
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    NSInteger index = x / self.scrollView.YY_width;
    BDJEssenceTitleButton *button = self.titlesView.subviews[index];
    [self titleButtonClick:button];
}


@end
