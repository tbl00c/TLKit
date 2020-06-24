//
//  UIColor+TLExtensions.h
//  Pods
//
//  Created by 李伯坤 on 2017/8/29.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (TLExtensions)

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(float)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
