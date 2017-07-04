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
#import "BDJEssenceTopicItem.h"
#import "BDJEssenceCollectionViewCell.h"
#import "BDJCheckPicktureController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


#define titles @[@"全部",@"视频",@"声音",@"图片",@"段子"]
#define titleCount titles.count

@interface BDJEssenceViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) UIView *titlesView;
@property (weak, nonatomic) BDJEssenceTitleButton *selectedTitleButton;
@property (weak, nonatomic) UIView *titleUnderlineView;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) AVPlayer *soundPlayer;
@property (strong, nonatomic) BDJEssenceTopicItem *lastSoundViewItem;

@end

@implementation BDJEssenceViewController

#pragma mark - Lazy Load

- (AVPlayer *)soundPlayer {
    if (!_soundPlayer) {
        _soundPlayer = [[AVPlayer alloc] init];
    }
    return _soundPlayer;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];

    [self setUpCollectionView];
    
    [self setUpTitlesView];
    
    
    //监听视频播放按钮被点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideo:) name:BDJVideoButtonDidClickNotification object:nil];
    //监听音频播放按钮被点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealWithSoundPlay:) name:BDJSoundButtonDidClickNotification object:nil];
    //监听音频播放完毕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(soundPlayEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //监听tabBar按钮被重复点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:BDJTabBarButtonDidRepeatClickNotification object:nil];
    //监听图片被点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureDidBeenClick:) name:BDJPhotoViewDidClickNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.soundPlayer pause];
    self.lastSoundViewItem.soundPlayStatus = NO;
    self.soundPlayer = nil;
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





- (void)setUpCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = self.view.bounds.size;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BDJEssenceCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"collectionViewCell"];
    
    CGFloat collectionViewWidth = collectionView.YY_width;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.contentSize = CGSizeMake(self.childViewControllers.count * collectionViewWidth, 0);
    collectionView.pagingEnabled = YES;
    collectionView.scrollsToTop = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:collectionView];
}

#pragma mark - CollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return titleCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BDJEssenceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    switch (indexPath.item) {
        case 0:
            cell.topicType = BDJTopicTypeAll;
            break;
        case 1:
            cell.topicType = BDJTopicTypeVideo;
            break;
        case 2:
            cell.topicType = BDJTopicTypeSound;
            break;
        case 3:
            cell.topicType = BDJTopicTypePhoto;
            break;
        case 4:
            cell.topicType = BDJTopicTypeCrossTalk;
            break;
        default:
            break;
    }
    
    
    return cell;
}



/**
 设置标题视图
 */
- (void)setUpTitlesView {
    UIView *titlesView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.YY_width, TitleHeight)];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
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
    //如果是重复点击，则发送通知
    if (self.selectedTitleButton == btn) {
        [[NSNotificationCenter defaultCenter] postNotificationName:BDJTitleButtonDidRepeatClickNotification object:nil];
    }
    //取消音频播放
    [self.soundPlayer pause];
    self.lastSoundViewItem.soundPlayStatus = NO;
    self.soundPlayer = nil;
    
    //处理标题按钮选中状态
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
        self.collectionView.contentOffset = CGPointMake(index * self.collectionView.YY_width, self.collectionView.contentOffset.y);
    } completion:^(BOOL finished) {
        
    }];
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
    NSInteger index = x / self.collectionView.YY_width;
    BDJEssenceTitleButton *button = self.titlesView.subviews[index];
    
    if (button != self.selectedTitleButton) {
        [self titleButtonClick:button];
    }
}

#pragma mark - 处理通知事件

/**
 处理视频按钮被点击
 */
- (void)playVideo:(NSNotification *)notification {
    AVPlayerViewController *avVC = [[AVPlayerViewController alloc] init];
    NSString *videoURL = notification.userInfo[@"videoURL"];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:videoURL]];
    avVC.player = player;
    [self presentViewController:avVC animated:YES completion:^{
        [avVC.player play];
    }];
}

/**
 处理声音按钮被点击
 */
- (void)dealWithSoundPlay:(NSNotification *)notification {
    
    BDJEssenceTopicItem *soundViewItem = notification.userInfo[@"soundItem"];
    NSString *soundURL = soundViewItem.voiceuri;
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:soundURL]];
    //判断音频对象是否为空，若为空，代表未播放过，直接播放。
    if (self.soundPlayer.currentItem == nil ) {
        self.soundPlayer = [AVPlayer playerWithPlayerItem:playerItem];
        [self.soundPlayer play];
        
        soundViewItem.soundPlayStatus = YES;
        self.lastSoundViewItem = soundViewItem;
    } else {//音频对象不为空，代表之前播放过
        //判断当前是否正在播放
        if (self.lastSoundViewItem.soundPlayStatus) {
            //判断点击的是否是同一个音频
            if ([self.lastSoundViewItem.voiceuri isEqualToString:soundURL]) {
                //是同一个音频，直接暂停
                [self.soundPlayer pause];
                self.lastSoundViewItem.soundPlayStatus = NO;
            } else {//不是同一个音频，停止之前的，替换掉音频对象，播放新的音频
                [self.soundPlayer pause];
                [self.soundPlayer replaceCurrentItemWithPlayerItem:playerItem];
                [self.soundPlayer play];
                self.lastSoundViewItem.soundPlayStatus = NO;
                soundViewItem.soundPlayStatus = YES;
                self.lastSoundViewItem = soundViewItem;
            }
        } else {
            if ([self.lastSoundViewItem.voiceuri isEqualToString:soundURL]) {
                //是同一个音频，直接恢复播放
                [self.soundPlayer play];
                soundViewItem.soundPlayStatus = YES;
            } else {//不是同一个音频，替换掉音频对象，播放新的音频
                [self.soundPlayer replaceCurrentItemWithPlayerItem:playerItem];
                [self.soundPlayer play];
                soundViewItem.soundPlayStatus = YES;
                self.lastSoundViewItem = soundViewItem;
            }
        }
    }
}

/**
 处理音频播放完毕
 */
- (void)soundPlayEnd:(NSNotification *)notification {
    self.lastSoundViewItem.soundPlayStatus = NO;
}

/**
 处理tabBar按钮被重复点击
 */
- (void)tabBarButtonDidRepeatClick {
    //如果重复点击的不是精华按钮，则不处理
    if (self.view.window == nil) return;
    
    //取消音乐播放
    [self.soundPlayer pause];
    self.lastSoundViewItem.soundPlayStatus = NO;
    self.soundPlayer = nil;
}

/**
 处理内容图片被点击
 */
- (void)pictureDidBeenClick:(NSNotification *)notification {
    BDJEssenceTopicItem *item = notification.userInfo[@"topicItem"];
    BDJCheckPicktureController *checkPictureVC = [[BDJCheckPicktureController alloc] init];
    checkPictureVC.item = item;
    [self presentViewController:checkPictureVC animated:NO completion:nil];
}

@end
