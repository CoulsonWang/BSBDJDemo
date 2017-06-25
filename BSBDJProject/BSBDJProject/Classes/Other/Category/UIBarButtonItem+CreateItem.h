//
//  UIBarButtonItem+CreateItem.h
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CreateItem)

+ (instancetype)itemWithImage:(UIImage *)image highLightImage:(UIImage *)highLightImage target:(nullable id)target action:(SEL)action;

@end
