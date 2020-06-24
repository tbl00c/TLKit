//
//  TLStatusBarAlert.m
//  LCGO
//
//  Created by lbk on 2018/4/1.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import "TLStatusBarAlert.h"
#import "TLLocalPushManager.h"
#import "JDStatusBarNotification.h"
#import "UIColor+TLKit.h"

@implementation TLStatusBarAlert

+ (void)showAutoHiddenAlertWithTitle:(NSString *)title
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [JDStatusBarNotification setDefaultStyle:^JDStatusBarStyle *(JDStatusBarStyle * _Nonnull style) {
            [style setBarColor:[UIColor colorContent]];
            [style setTextColor:[UIColor colorLabel]];
            [style setFont:[UIFont boldSystemFontOfSize:13]];
            return style;
        }];
    });
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        [[TLLocalPushManager sharedInstance] pushNotificationWithTitle:title content:@"快来看看吧 >>>"];
        return;
    }
    [JDStatusBarNotification showWithStatus:title dismissAfter:4.0f];
}

@end
