//
//  BDJEssenceRefreshHeaderView.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/29.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJEssenceRefreshHeaderView.h"

@implementation BDJEssenceRefreshHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)refreshHeader {
    BDJEssenceRefreshHeaderView *refreshHeader = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    return refreshHeader;
}

@end
