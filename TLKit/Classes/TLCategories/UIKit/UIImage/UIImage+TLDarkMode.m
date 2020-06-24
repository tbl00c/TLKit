//
//  UIImage+TLDarkMode.m
//  TLKit
//
//  Created by 李伯坤 on 2020/4/12.
//

#import "UIImage+TLDarkMode.h"
#import "TLTheme.h"

@implementation UIImage (TLDarkMode)

+ (UIImage *)imageWithLight:(UIImage *)lightImage dark:(UIImage *)darkImage
{
    if (!lightImage) {
        return nil;
    }
#if __IPHONE_13_0
    if (@available(iOS 13.0, *)) {
        UITraitCollection *lightCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
        UITraitCollection *darkCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
        UITraitCollection *unspecifiedCollection = [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight];
        UIImage *darkPure = [darkImage.imageAsset imageWithTraitCollection:unspecifiedCollection];
        UIImage *lightPure = [lightImage.imageAsset imageWithTraitCollection:unspecifiedCollection];
        UIImage *image = lightPure.copy;
        [image.imageAsset registerImage:lightPure withTraitCollection:lightCollection];
        [image.imageAsset registerImage:darkPure withTraitCollection:darkCollection];
        [image.imageAsset registerImage:lightPure withTraitCollection:unspecifiedCollection];
        return image;
    }
    else {
#endif
        TLThemeStyle style = [TLTheme sharedInstance].themeStyle;
        if (style == TLThemeStyleDark) {
            return darkImage;
        }
        return lightImage;
#if __IPHONE_13_0
    }
#endif
}

+ (UIImage *)imageWithLightName:(NSString *)lightName darkName:(NSString *)darkName
{
    UIImage *image = [self imageWithLight:[UIImage imageNamed:lightName] dark:[UIImage imageNamed:darkName]];
    return image;
}

@end
