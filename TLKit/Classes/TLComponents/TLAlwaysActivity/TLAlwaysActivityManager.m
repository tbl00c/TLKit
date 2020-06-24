//
//  TLAlwaysActivityManager.m
//  LCGO
//
//  Created by 李伯坤 on 2018/10/26.
//  Copyright © 2018 李伯坤. All rights reserved.
//

#import "TLAlwaysActivityManager.h"
#import <AVFoundation/AVFoundation.h>
#import "NSTimer+TLBlock.h"

@interface TLAlwaysActivityManager ()

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TLAlwaysActivityManager

+ (TLAlwaysActivityManager *)sharedInstance
{
    static TLAlwaysActivityManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TLAlwaysActivityManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        [self reset];
    }
    return self;
}

- (void)reset
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:self.debug ? @"test" : @"silence" ofType:@"m4a"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
    self.player.volume = self.debug ? 1.0f : 0.0f;
    self.player.numberOfLoops = -1;
}

- (void)dealloc
{
    [self.timer invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

static int __lc_always_activity_manager_time_count;
- (void)start
{
    NSLog(@"【TLAlwaysActivityManager】开始播放音乐");
    [self.player play];
    [self.timer invalidate];
    __lc_always_activity_manager_time_count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        NSLog(@"【TLAlwaysActivityManager】后台计时：%d", ++__lc_always_activity_manager_time_count);
    } repeats:YES];
    
    if (self.status != TLAlwaysActivityManagerStatusStart) {
        self.status = TLAlwaysActivityManagerStatusStart;
        if (self.statusChangedAction) {
            self.statusChangedAction(self, self.status);
        }
    }
    
    __weak typeof(self) weakSelf = self;
    __block UIBackgroundTaskIdentifier bgId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"【TLAlwaysActivityManager】应用被系统挂起");
        [[UIApplication sharedApplication] endBackgroundTask:bgId];
        weakSelf.status = TLAlwaysActivityManagerStatusExpiration;
        if (weakSelf.statusChangedAction) {
            weakSelf.statusChangedAction(self, self.status);
        }
    }];
}

- (void)stop
{
    NSLog(@"【TLAlwaysActivityManager】停止播放音乐");
    self.status = TLAlwaysActivityManagerStatusStop;
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self.player pause];
    [self.timer invalidate];
    if (self.statusChangedAction) {
        self.statusChangedAction(self, self.status);
    }
}

#pragma mark - # Debug
- (BOOL)debug
{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"tl_always_activity_manager_debug"];
    return number.boolValue;
}
- (void)setDebug:(BOOL)debug
{
    [[NSUserDefaults standardUserDefaults] setObject:@(debug) forKey:@"tl_always_activity_manager_debug"];
}

@end
