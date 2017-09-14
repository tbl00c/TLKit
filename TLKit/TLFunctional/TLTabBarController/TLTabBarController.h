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

/**
 *  添加子控制器
 *
 *  @param  viewController      视图控制器
 *  @param  actionBlock         切换事件，返回是否允许切换
 */
- (void)addChildViewController:(UIViewController *)viewController actionBlock:(BOOL (^)())actionBlock;


/**
 *  添加子控制器
 *
 *  @param  systemTabBarItem    系统tabBarItem
 *  @param  actionBlock         切换事件
 */
- (void)addPlusItemWithSystemTabBarItem:(UITabBarItem *)systemTabBarItem actionBlock:(void (^)())actionBlock;

@end


#pragma mark - ## UITabBar (TLExtension)
@interface UITabBar (TLExtension)

/**
 *  tabbar顶部线
 */
- (void)setHiddenShadow:(BOOL)hiddenShadow;

/**
 *  tabbar顶部黑线颜色
 */
- (void)setShadowColor:(UIColor *)shadowColor;

@end
