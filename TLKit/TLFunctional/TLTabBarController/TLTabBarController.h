//
//  TLTabBarController.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTabBarControllerProtocol.h"

#pragma mark - ## TLTabBarController
@interface TLTabBarController : UITabBarController

@end


#pragma mark - ## UITabBar (TLExtension)
@interface UITabBar (TLExtension)

/// 隐藏tabbar顶部黑线
- (void)setHiddenShadow;

@end
