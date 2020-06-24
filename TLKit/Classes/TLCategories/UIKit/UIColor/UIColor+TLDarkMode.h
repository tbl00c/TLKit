//
//  UIColor+TLDarkMode.h
//  TLKit
//
//  Created by 李伯坤 on 2020/4/12.
//

#import <UIKit/UIKit.h>

@interface UIColor (TLDarkMode)

@property (nonatomic, strong, readonly) UIColor *lightColor;

@property (nonatomic, strong, readonly) UIColor *darkColor;

+ (UIColor *)colorWithLight:(UIColor *)light dark:(UIColor *)dark;

@end
