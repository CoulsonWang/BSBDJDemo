//
//  BDJSquareCollectionViewCell.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJSquareCollectionViewCell.h"
#import "BDJSquareItem.h"
#import <UIImageView+WebCache.h>

@interface BDJSquareCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@end

@implementation BDJSquareCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(BDJSquareItem *)item {
    _item = item;
    self.nameLable.text = item.name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
}

@end
