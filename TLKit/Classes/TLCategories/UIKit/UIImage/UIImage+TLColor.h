//
//  UIImage+TLColor.h
//  TLChat
//
//  Created by libokun on 15/9/6.
//  Copyright (c) 2015年 libokun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TLColor)

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageWithColor:(UIColor *)color;

// 灰色图像
- (UIImage *)grayImage;

@end
