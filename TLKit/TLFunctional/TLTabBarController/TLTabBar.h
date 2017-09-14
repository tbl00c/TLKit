//
//  TLTabBar.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTabBar : UITabBar

@property (nonatomic, copy) void (^didSelectItemAtIndex)(NSInteger index);
@property (nonatomic, copy) void (^didDoubleClickItemAtIndex)(NSInteger index);

/**
 * 根据系统的tabBar初始化
 */
- (id)initWithSystemTabBar:(UITabBar *)systemTabBar;

/**
 * 添加tabbarItem
 */
- (void)addTabBarItemWithSystemTabBarItem:(UITabBarItem *)systemTabBarItem;

@end
