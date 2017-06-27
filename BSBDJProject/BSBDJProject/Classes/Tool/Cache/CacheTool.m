//
//  CacheTool.m
//  文件缓存
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//  处理文件缓存的工具类

#import "CacheTool.h"

@implementation CacheTool

+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion {
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist) {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"文件不存在" userInfo:nil];
        [excp raise];
    }
    if (!isDirectory) {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"该路径不是文件夹路径" userInfo:nil];
        [excp raise];
    }
    //避免阻塞主线程，在子线程中计算缓存大小
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *pathArray = [mgr subpathsAtPath:directoryPath];
        NSInteger totalSize = 0;
        for (NSString *path in pathArray) {
            NSString *filePath = [directoryPath stringByAppendingPathComponent:path];
            if ([filePath containsString:@".DS"]) continue;
            BOOL isDirectory;
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (isDirectory || !isExist) continue;
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            NSInteger fileSize = [attr fileSize];
            totalSize += fileSize;
        }
        if (completion) {
            //计算完毕后，在主线程中调用block，进行UI更新操作
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(totalSize);
            });
        }
    });
    
}

+ (NSString *)getSizeString:(NSInteger)totalSize {
    NSString *sizeStr;
    if (totalSize >= 1000 * 1000 * 1000) {
        sizeStr = [NSString stringWithFormat:@"%.1fGB",totalSize / 1000.0 / 1000.0 / 1000.0];
    }else if (totalSize >= 1000 * 1000) {
        sizeStr = [NSString stringWithFormat:@"%.1fMB",totalSize / 1000.0 / 1000.0];
    } else if (totalSize >= 1000) {
        sizeStr = [NSString stringWithFormat:@"%.1fKB",totalSize / 1000.0];
    } else {
        sizeStr = [NSString stringWithFormat:@"%ldB",totalSize];
    }
    return sizeStr;
}

+ (void)removeFileOfDirectory:(NSString *)directoryPath {
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist) {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"文件不存在" userInfo:nil];
        [excp raise];
    }
    if (!isDirectory) {
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"该路径不是文件夹路径" userInfo:nil];
        [excp raise];
    }
    
    
    NSArray *filepathes = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    for (NSString *filepath in filepathes) {
        NSString *path = [directoryPath stringByAppendingPathComponent:filepath];
        [mgr removeItemAtPath:path error:nil];
    }
}



@end
