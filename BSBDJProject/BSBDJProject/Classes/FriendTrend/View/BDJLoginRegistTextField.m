//
//  BDJLoginRegistTextField.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJLoginRegistTextField.h"
#import "UITextField+Placeholder.h"

@implementation BDJLoginRegistTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    //设置placeholder默认字体样式
    self.placeholderColor = [UIColor lightGrayColor];
    
    [self addTarget:self action:@selector(textEditBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEditEnd) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)textEditBegin {
    self.placeholderColor = [UIColor whiteColor];
}

- (void)textEditEnd {
    self.placeholderColor = [UIColor lightGrayColor];
}




@end
