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

@property (assign, nonatomic) BDJTopicType type;

@property (strong, nonatomic) NSArray *top_cmt;

@property (assign, nonatomic) NSInteger width;

@property (assign, nonatomic) NSInteger height;

@property (strong, nonatomic) NSString *image0;

@property (strong, nonatomic) NSString *image2;

@property (strong, nonatomic) NSString *image1;

@property (assign, nonatomic) NSInteger voicetime;

@property (assign, nonatomic) NSInteger videotime;

@property (assign, nonatomic) NSInteger playcount;

@property (strong, nonatomic) NSString *voiceuri;

@property (strong, nonatomic) NSString *videouri;

@property (strong, nonatomic) NSString *is_gif;

//额外属性，并非服务器返回的属性
/** 根据当前模型计算出的cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;

@property (assign, nonatomic) CGRect middelFrame;

@property (assign, nonatomic) BOOL soundPlayStatus;

@property (assign, nonatomic, getter=isLongPicture) BOOL longPicture;

@end
