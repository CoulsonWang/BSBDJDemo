//
//  BDJEssenceCollectionViewCell.h
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/7/3.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDJEssenceTopicItem.h"

@class BDJEssenceTopicItem;

@interface BDJEssenceCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) NSMutableArray<BDJEssenceTopicItem *> *topicItems;

@property (assign, nonatomic) BDJTopicType topicType;

@end
