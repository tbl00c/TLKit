//
//  TLAlwaysActivityManager.h
//  LCGO
//
//  Created by 李伯坤 on 2018/10/26.
//  Copyright © 2018 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TLAlwaysActivityManagerStatus) {
    TLAlwaysActivityManagerStatusStop = 0,
    TLAlwaysActivityManagerStatusStart,
    TLAlwaysActivityManagerStatusExpiration,
};

@interface TLAlwaysActivityManager : NSObject

@property (nonatomic, assign) BOOL debug;
@property (nonatomic, assign) TLAlwaysActivityManagerStatus status;

@property (nonatomic, copy) void (^statusChangedAction)(TLAlwaysActivityManager *manager, TLAlwaysActivityManagerStatus status);

+ (TLAlwaysActivityManager *)sharedInstance;

- (void)reset;

- (void)start;

- (void)stop;

@end
