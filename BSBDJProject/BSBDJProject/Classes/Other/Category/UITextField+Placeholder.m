//
//  UITextField+Placeholder.m
//  设置占位文字颜色
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (Placeholder)

+ (void)load {
    Method orignalMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method customMethod = class_getInstanceMethod(self, @selector(setPlaceholder_Custom:));
    method_exchangeImplementations(orignalMethod, customMethod);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    objc_setAssociatedObject(self, "placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, "placeholderColor");
}

- (void)setPlaceholder_Custom:(NSString *)placeholder {
    [self setPlaceholder_Custom:placeholder];
    
    self.placeholderColor = self.placeholderColor;
}

@end
