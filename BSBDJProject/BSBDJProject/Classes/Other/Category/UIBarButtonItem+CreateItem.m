//
//  UIBarButtonItem+CreateItem.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "UIBarButtonItem+CreateItem.h"

@implementation UIBarButtonItem (CreateItem)

+ (instancetype)itemWithImage:(UIImage *)image highLightImage:(UIImage *)highLightImage target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highLightImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

+ (instancetype)itemWithImage:(UIImage *)image highLightImage:(UIImage *)highLightImage selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highLightImage forState:UIControlStateHighlighted];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:btn.bounds];
    [view addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:view];
}

+ (instancetype)backItemWithImage:(UIImage *)image highLightImage:(UIImage *)highLightImage target:(id)target action:(SEL)action title:(NSString *)title {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton setImage:image forState:UIControlStateNormal];
    [leftButton setImage:highLightImage forState:UIControlStateHighlighted];
    [leftButton sizeToFit];
    leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}


@end
