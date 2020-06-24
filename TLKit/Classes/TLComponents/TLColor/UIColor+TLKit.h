//
//  UIColor+TLKit.h
//  LCGO
//
//  Created by lbk on 2018/3/9.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TLKit)

#pragma mark - # 白色
+ (UIColor *)colorWhite;

#pragma mark - # 黑色
+ (UIColor *)colorBlack;

#pragma mark - # 灰色
+ (UIColor *)colorGray;
+ (UIColor *)colorDarkGray;
+ (UIColor *)colorLightGray;
+ (UIColor *)colorGrayTips;

#pragma mark - # 绿色
+ (UIColor *)colorGreen;
+ (UIColor *)colorGreenHL;


#pragma mark - # 红色
+ (UIColor *)colorRed;
+ (UIColor *)colorRedHL;

#pragma mark - # 蓝色
+ (UIColor *)colorBlue;

#pragma mark - # 黄色
+ (UIColor *)colorYellow;

#pragma mark - # 粉色
+ (UIColor *)colorLightPink;

#pragma mark - # 标准
+ (UIColor *)colorNavBarBG;
+ (UIColor *)colorNavBarTint;
+ (UIColor *)colorNavBarTitle;

+ (UIColor *)colorTabBarBG;
+ (UIColor *)colorTabBarTint;
+ (UIColor *)colorTabBarUnselectedTint;

+ (UIColor *)colorMenuBarBG;
+ (UIColor *)colorMenuBarTint;
+ (UIColor *)colorMenuBarUnselectedTint;
+ (UIColor *)colorMenuPopupBG;
+ (UIColor *)colorMenuPopupTint;

+ (UIColor *)colorControlBarBG;

+ (UIColor *)colorShadow;

/// 背景
+ (UIColor *)colorBG;
/// 内容
+ (UIColor *)colorContent;
/// 分割线
+ (UIColor *)colorSeperator;
/// 字体色
+ (UIColor *)colorLabel;
+ (UIColor *)colorSecondaryLabel;
+ (UIColor *)colorTertiaryLabel;
+ (UIColor *)colorQuaternaryLabel;

@end
