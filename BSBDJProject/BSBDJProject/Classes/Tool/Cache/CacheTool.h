//
//  CacheTool.h
//  文件缓存
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//  处理文件缓存的工具类

#import <Foundation/Foundation.h>

@interface CacheTool : NSObject

/**
 获取文件夹尺寸

 @param directoryPath 文件夹路径
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;

/**
 获取描述文件尺寸的字符串

 @param totalSize 文件总大小(单位:Byte)
 @return 文件大小字符串(单位:GB或MB或KB或B)
 */
+ (NSString *)getSizeString:(NSInteger)totalSize;

/**
 删除目标文件目录下的所有文件

 @param directoryPath 目标文件目录
 */
+ (void)removeFileOfDirectory:(NSString *)directoryPath;

@end
