//
//  TLLocalPushManager.m
//  LCGO
//
//  Created by lbk on 2018/4/29.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import "TLLocalPushManager.h"

@implementation TLLocalPushManager

+ (TLLocalPushManager *)sharedInstance
{
    static TLLocalPushManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TLLocalPushManager alloc] init];
    });
    return manager;
}

- (void)pushNotificationWithTitle:(NSString *)title content:(NSString *)content
{
    [self pushNotificationWithTitle:title content:content after:0];
}

- (void)pushNotificationWithTitle:(NSString *)title content:(NSString *)content after:(CGFloat)after
{
    UILocalNotification *noti = [[UILocalNotification alloc]init];
    noti.timeZone = [NSTimeZone defaultTimeZone];
    noti.fireDate = [NSDate dateWithTimeIntervalSinceNow:after];
    if (@available(iOS 8.2, *)) {
        noti.alertTitle = title;
        noti.alertBody = content;
    } else {
        noti.alertBody = [title ? title : @"" stringByAppendingString:content ? content : @""];
    }
    noti.hasAction = YES;
    noti.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:noti];
}

@end
