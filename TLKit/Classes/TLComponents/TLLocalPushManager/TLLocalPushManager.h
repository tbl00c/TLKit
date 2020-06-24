//
//  TLLocalPushManager.h
//  LCGO
//
//  Created by lbk on 2018/4/29.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLLocalPushManager : NSObject

+ (TLLocalPushManager *)sharedInstance;

- (void)pushNotificationWithTitle:(NSString *)title content:(NSString *)content;

- (void)pushNotificationWithTitle:(NSString *)title content:(NSString *)content after:(CGFloat)after;

@end
