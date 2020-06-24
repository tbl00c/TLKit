//
//  UIColor+TLKit.m
//  LCGO
//
//  Created by lbk on 2018/3/9.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import "UIColor+TLKit.h"
#import "UIColor+TLExtensions.h"
#import "TLShortcutMacros.h"
#import "UIColor+TLDarkMode.h"

#define KEY_LCCOLOR_NORMAL      @"normal"
#define KEY_LCCOLOR_DARK        @"dark"

#define TLCOLOR_IMP(methodName, colorKey)    \
+ (UIColor *)methodName {   \
    return [TLColorProducter colorWithName:colorKey];   \
}

static NSDictionary *__tl_colorTable;
@interface TLColorProducter : NSObject
+ (UIColor *)colorWithName:(NSString *)name;
+ (UIColor *)lightColorWithName:(NSString *)name;
+ (UIColor *)darkColorWithName:(NSString *)name;
@end

@implementation TLColorProducter

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *path = [bundle pathForResource:@"TLColorTable" ofType:@"txt"];
        NSString *code = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        code = [code stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
        while ([code containsString:@"  "]) {
            code = [code stringByReplacingOccurrencesOfString:@"  " withString:@" "];
        }
        NSArray *colorLines = [code componentsSeparatedByString:@"\n"];
        NSMutableDictionary *colorTable = [[NSMutableDictionary alloc] init];
        for (NSString *colorString in colorLines) {
            if ([colorString hasPrefix:@"#"] || [colorString hasPrefix:@"//"]) {
                continue;
            }
            NSArray *colorStringArray = [colorString componentsSeparatedByString:@" "];
            NSString *colorName = colorStringArray.count > 0 ? colorStringArray[0] : @"";
            NSString *normalColorHex = colorStringArray.count > 1 ? colorStringArray[1] : @"";
            NSString *dartColorHex = colorStringArray.count > 2 ? colorStringArray[2] : @"";
            if (colorName.length > 0 && normalColorHex.length > 0) {
                NSDictionary *colorDic = @{};
                if ([normalColorHex hasPrefix:@"="]) {
                    NSString *mapKey = [normalColorHex substringFromIndex:1];
                    NSMutableDictionary *mapColor = [[colorTable objectForKey:mapKey] mutableCopy];
                    if (!mapColor) {
                        mapColor = @{}.mutableCopy;
                    }
                    if ([dartColorHex hasPrefix:@"#"]) {
                        mapColor[KEY_LCCOLOR_DARK] = dartColorHex;
                    }
                    else if ([dartColorHex hasPrefix:@"="]) {
                        NSString *darkMapKey = [dartColorHex substringFromIndex:1];
                        NSDictionary *mapDarkColor = [colorTable objectForKey:darkMapKey];
                        if (mapDarkColor) {
                            if ([mapDarkColor[KEY_LCCOLOR_DARK] length] > 0) {
                                mapColor[KEY_LCCOLOR_DARK] = mapDarkColor[KEY_LCCOLOR_DARK];
                            }
                            else if ([mapDarkColor[KEY_LCCOLOR_NORMAL] length] > 0) {
                                mapColor[KEY_LCCOLOR_DARK] = mapDarkColor[KEY_LCCOLOR_NORMAL];
                            }
                        }
                    }
                    else {
                        colorDic = mapColor ? mapColor : @{};
                    }
                    colorDic = mapColor ? mapColor : @{};
                }
                else {
                    colorDic = @{
                        KEY_LCCOLOR_NORMAL : normalColorHex,
                        KEY_LCCOLOR_DARK : dartColorHex.length > 0 ? dartColorHex : normalColorHex,
                    };
                }
                [colorTable setObject:colorDic forKey:colorName];
            }
        }
        __tl_colorTable = colorTable;
    });
}


+ (UIColor *)colorWithName:(NSString *)name
{
    UIColor *lightColor = [self lightColorWithName:name];
    UIColor *darkColor = [self darkColorWithName:name];
    return [UIColor colorWithLight:lightColor dark:darkColor];
}

+ (UIColor *)lightColorWithName:(NSString *)name
{
    NSDictionary *colorMap = [__tl_colorTable objectForKey:name];
    NSString *colorHex = [colorMap objectForKey:KEY_LCCOLOR_NORMAL];
    return [UIColor colorWithHexString:colorHex];
}

+ (UIColor *)darkColorWithName:(NSString *)name
{
    NSDictionary *colorMap = [__tl_colorTable objectForKey:name];
    NSString *colorHex = [colorMap objectForKey:KEY_LCCOLOR_DARK];
    return [UIColor colorWithHexString:colorHex];
}

@end


@implementation UIColor (TLKit)


#pragma mark - # 白色
TLCOLOR_IMP(colorWhite, @"white")

#pragma mark - # 黑色
TLCOLOR_IMP(colorBlack, @"black")

#pragma mark - # 灰色
TLCOLOR_IMP(colorGray, @"gray")
TLCOLOR_IMP(colorDarkGray, @"darkGray")
TLCOLOR_IMP(colorLightGray, @"lightGray")
TLCOLOR_IMP(colorGrayTips, @"grayTips")

#pragma mark - # 绿色
TLCOLOR_IMP(colorGreen, @"green")
TLCOLOR_IMP(colorGreenHL, @"greenHL")

#pragma mark - # 红色
TLCOLOR_IMP(colorRed, @"red")
TLCOLOR_IMP(colorRedHL, @"redHL")

#pragma mark - # 蓝色
TLCOLOR_IMP(colorBlue, @"blue")

#pragma mark - # 黄色
TLCOLOR_IMP(colorYellow, @"yellow")

#pragma mark - # 粉色
TLCOLOR_IMP(colorLightPink, @"lightPink")

#pragma mark - # 标准
TLCOLOR_IMP(colorNavBarTint, @"navBarTint")
TLCOLOR_IMP(colorNavBarBG, @"navBarBG")
TLCOLOR_IMP(colorNavBarTitle, @"navBarTitle")

TLCOLOR_IMP(colorTabBarTint, @"tabBarTint")
TLCOLOR_IMP(colorTabBarBG, @"tabBarBG")
TLCOLOR_IMP(colorTabBarUnselectedTint, @"tabBarUnselectedTint")

TLCOLOR_IMP(colorMenuBarTint, @"menuBarTint")
TLCOLOR_IMP(colorMenuBarUnselectedTint, @"menuBarUnselectedTint")
TLCOLOR_IMP(colorMenuBarBG, @"menuBarBG")
TLCOLOR_IMP(colorMenuPopupBG, @"menuPopupBG")
TLCOLOR_IMP(colorMenuPopupTint, @"menuPopupTint")

TLCOLOR_IMP(colorControlBarBG, @"controlBarBG")

TLCOLOR_IMP(colorShadow, @"shadow")

TLCOLOR_IMP(colorBG, @"background")
TLCOLOR_IMP(colorContent, @"content")
TLCOLOR_IMP(colorSeperator, @"seperator")
TLCOLOR_IMP(colorLabel, @"label")
TLCOLOR_IMP(colorSecondaryLabel, @"secondaryLabel")
TLCOLOR_IMP(colorTertiaryLabel, @"tertiaryLabel")
TLCOLOR_IMP(colorQuaternaryLabel, @"quaternaryLabel")



@end
