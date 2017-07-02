//
//  BDJEssenceRefreshHeaderView.h
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/29.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJEssenceRefreshHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activeIndicator;

+ (instancetype)refreshHeader;

@end
