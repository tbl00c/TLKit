//
//  TLAlertnateIconManager.m
//  LCGO
//
//  Created by 李伯坤 on 2018/5/15.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLAlertnateIconManager.h"

@implementation TLAlertnateIconManager

+ (BOOL)changeIconByName:(NSString *)iconName
{
    NSLog(@"【动态Icon】更换icon：%@", iconName);
#ifdef __IPHONE_10_3
    if (@available(iOS 10.3, *)) {
        if (![[UIApplication sharedApplication] respondsToSelector:@selector(supportsAlternateIcons)]) {
            return NO;
        }
        if ([UIApplication sharedApplication].supportsAlternateIcons) {
            iconName = iconName.length == 0 ? nil : iconName;
            [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
                if (error) {
                    if (iconName) {
                        NSLog(@"【动态Icon】ICON动态更换出错：%@", [error description]);
                        [self changeIconByName:nil delay:1.0];
                    }
                    else {
                        NSLog(@"【动态Icon】换回系统icon");
                    }
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"app_icon"];
                }
                else {
                    if (iconName) {
                        [[NSUserDefaults standardUserDefaults] setObject:iconName forKey:@"app_icon"];
                    }
                    else {
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"app_icon"];
                    }
                    NSLog(@"【动态Icon】ICON更换成功：%@", iconName);
                }
            }];
            return YES;
        }
    }
#endif
    return NO;
}

+ (BOOL)changeIconByName:(NSString *)iconName delay:(CGFloat)delay
{
    NSLog(@"【动态Icon】%lf秒后，更换icon：%@", delay, iconName);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self changeIconByName:iconName];
    });
    return YES;
}

@end
