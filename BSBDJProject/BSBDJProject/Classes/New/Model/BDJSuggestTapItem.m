//
//  BDJSuggestTapItem.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJSuggestTapItem.h"

@implementation BDJSuggestTapItem

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@", _image_list,_sub_number,_theme_name];
}

@end
