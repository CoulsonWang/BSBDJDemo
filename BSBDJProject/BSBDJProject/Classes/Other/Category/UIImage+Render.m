//
//  UIImage+Render.m
//  快速生成不渲染的图片
//
//  Created by Coulson_Wang on 2017/6/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)

+ (instancetype)imageWithOriginalRenderMode:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (instancetype)circleImage {
    UIGraphicsBeginImageContext(self.size);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    [path addClip];
    
    [self drawAtPoint:CGPointZero];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

+ (instancetype)circleImageWithName:(NSString *)imageName {
    UIImage *image = [self imageNamed:imageName];
    return [image circleImage];
}

@end
