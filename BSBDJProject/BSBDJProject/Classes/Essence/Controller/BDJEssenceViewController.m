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


@interface BDJEssenceViewController ()

@property (weak, nonatomic) UIView *titlesView;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) BDJEssenceTitleButton *selectedTitleButton;

@end

@implementation BDJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
    
    [self setUpScrollView];
    
    [self setUpTitlesView];
}



/**
 设置导航条
 */
- (void)setUpNavigationBar {
    //通过调用分类中的类方法快速创建UIBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highLightImage:[UIImage imageNamed:@"nav_item_game_click_icon"]target:self action:@selector(leftNavBtnClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highLightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(rightNavBtnClick)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}



- (void)setUpScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setUpTitlesView {
    UIView *titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.YY_width, 44)];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    [self setUpTitleButtons];
    [self setUpTitleUnderline];
}

- (void)setUpTitleButtons {
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger titleCount = titles.count;
    
    CGFloat titleWidth = self.titlesView.YY_width / titleCount;
    CGFloat titleHeight = self.titlesView.YY_height;
    
    for (int i = 0; i < titleCount; i++) {
        BDJEssenceTitleButton *titleButton = [BDJEssenceTitleButton buttonWithType:UIButtonTypeCustom];
        [self.titlesView addSubview:titleButton];
        titleButton.frame = CGRectMake(i * titleWidth, 0, titleWidth, titleHeight);
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)titleButtonClick:(BDJEssenceTitleButton *)btn {
    self.selectedTitleButton.selected = NO;
    btn.selected = YES;
    self.selectedTitleButton = btn;
}

- (void)setUpTitleUnderline {
    
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

@end
