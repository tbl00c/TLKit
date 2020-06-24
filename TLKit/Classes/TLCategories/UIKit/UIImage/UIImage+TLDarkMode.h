//
//  UIImage+TLDarkMode.h
//  TLKit
//
//  Created by 李伯坤 on 2020/4/12.
//

#import <UIKit/UIKit.h>

#define     TLLightDarkImage(lightImage, darkImage)                     [UIImage imageWithLight:lightImage dark:darkImage]
#define     TLLightDarkImageNamed(lightImageName, darkImageName)        [UIImage imageWithLightName:lightImageName darkName:darkImageName]

@interface UIImage (TLDarkMode)

+ (UIImage *)imageWithLight:(UIImage *)lightImage dark:(UIImage *)darkImage;

+ (UIImage *)imageWithLightName:(NSString *)lightName darkName:(NSString *)darkName;

@end

