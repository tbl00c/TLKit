//
//  UIImage+TLColor.m
//  TLChat
//
//  Created by libokun on 15/9/6.
//  Copyright (c) 2015年 libokun. All rights reserved.
//

#import "UIImage+TLColor.h"
#import "UIColor+TLDarkMode.h"
#import "UIImage+TLDarkMode.h"

@implementation UIImage (TLColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    UIImage *lightImage;
    UIImage *darkImage;
    UIColor *lightColor = color.lightColor;
    UIColor *darkColor = color.darkColor;
    if (lightColor) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [lightColor CGColor]);
        CGContextFillRect(context, rect);
        lightImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    if (darkColor) {
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [darkColor CGColor]);
        CGContextFillRect(context, rect);
        darkImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIImage *image = [UIImage imageWithLight:lightImage dark:darkImage];
    return image;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    UIImage *lightImage;
    UIImage *darkImage;
    UIColor *lightColor = color.lightColor;
    UIColor *darkColor = color.darkColor;
    if (lightColor) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, self.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
        CGContextClipToMask(context, rect, self.CGImage);
        [lightColor setFill];
        CGContextFillRect(context, rect);
        lightImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    if (darkColor) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, self.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
        CGContextClipToMask(context, rect, self.CGImage);
        [darkColor setFill];
        CGContextFillRect(context, rect);
        darkImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    UIImage *image = [UIImage imageWithLight:lightImage dark:darkImage];
    return image;
}


#pragma mark - 
- (UIImage *)grayImage {
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  kCGBitmapByteOrderDefault);
    
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    CGContextRelease(context);
    
    return grayImage;
}

@end
