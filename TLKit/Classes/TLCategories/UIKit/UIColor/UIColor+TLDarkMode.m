//
//  UIColor+TLDarkMode.m
//  TLKit
//
//  Created by 李伯坤 on 2020/4/12.
//

#import "UIColor+TLDarkMode.h"
#import "TLTheme.h"

@implementation UIColor (TLDarkMode)

- (UIColor *)lightColor
{
    if (@available(iOS 13.0, *)) {
#ifdef __IPHONE_13_0
        UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
        UIColor *color = [self resolvedColorWithTraitCollection:traitCollection];
        return color;
#endif
    }
    return self;
}

- (UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
#ifdef __IPHONE_13_0
        UITraitCollection *traitCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
        UIColor *color = [self resolvedColorWithTraitCollection:traitCollection];
        return color;
#endif
    }
    return self;
}

+ (UIColor *)colorWithLight:(UIColor *)light dark:(UIColor *)dark
{

    if (@available(iOS 13.0, *)) {
#if __IPHONE_13_0
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if ([TLTheme sharedInstance].obeySystemSetting) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return dark;
                }
                return light;
            }
            TLThemeStyle style = [TLTheme sharedInstance].themeStyle;
            if (style == TLThemeStyleDark) {
                return dark ? dark : light;
            }
            return light;
        }];
#endif
    }
    
    TLThemeStyle style = [TLTheme sharedInstance].themeStyle;
    if (style == TLThemeStyleLight) {
        return light;
    }
    else if (style == TLThemeStyleDark) {
        return dark ? dark : light;
    }
    return light;
}

@end
