//
//  BDJEssenceTopicItem.h
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/29.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BDJTopicType) {
    BDJTopicTypeAll = 1,
    BDJTopicTypePhoto = 10,
    BDJTopicTypeCrossTalk = 29,
    BDJTopicTypeSound = 31,
    BDJTopicTypeVideo = 41
};

@interface BDJEssenceTopicItem : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *profile_image;

@property (strong, nonatomic) NSString *passtime;

@property (strong, nonatomic) NSString *text;

@property (strong, nonatomic) NSString *ding;

@property (strong, nonatomic) NSString *cai;

@property (strong, nonatomic) NSString *repost;

@property (strong, nonatomic) NSString *comment;

@property (assign, nonatomic) NSInteger type;

@end
