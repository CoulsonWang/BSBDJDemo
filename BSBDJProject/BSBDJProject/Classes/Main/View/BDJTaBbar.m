//
//  BDJTaBbar.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJTaBbar.h"

@interface BDJTaBbar ()

@property (nonatomic, weak) UIButton *publishBtn;
@property (weak, nonatomic) UIControl *lastClickTabBarButton;

@end

@implementation BDJTaBbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

/**
 懒加载按钮，确保按钮只会被添加一次
 */
- (UIButton *)publishBtn {
    if (!_publishBtn) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton sizeToFit];
        
        [self addSubview:publishButton];
        _publishBtn = publishButton;
    }
    return _publishBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnW = self.bounds.size.width / (self.items.count + 1);
    CGFloat btnH = self.bounds.size.height;
    
    NSInteger i = 0;
    for (UIControl *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //设置默认值为第一个按钮
            if (i == 0 && self.lastClickTabBarButton == nil) {
                self.lastClickTabBarButton = view;
            }
            
            //空一个位置出来给中间的按钮
            if (i == 2) {
                i++;
            }
            view.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
            i++;
            
            //监听按钮点击
            [view addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.publishBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

- (void)tabBarButtonClick:(UIControl *)tabBarButton {
    if (self.lastClickTabBarButton == tabBarButton) {
        //发布通知
        [[NSNotificationCenter defaultCenter] postNotificationName:BDJTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.lastClickTabBarButton = tabBarButton;
}

@end
