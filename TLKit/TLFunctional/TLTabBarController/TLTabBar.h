//
//  TLTabBar.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTabBar : UITabBar

/// 单击（已选中状态）
@property (nonatomic, copy) void (^didSelectItemAtIndex)(NSInteger index);

/// 双击
@property (nonatomic, copy) void (^didDoubleClickItemAtIndex)(NSInteger index);

/**
 *  根据系统的tabBar初始化
 */
- (id)initWithSystemTabBar:(UITabBar *)systemTabBar;

/**
 *  添加tabbarItem
 *
 *  @param  actionBlock     自定义选中事件，默认传nil
 */
- (void)addTabBarItemWithSystemTabBarItem:(UITabBarItem *)systemTabBarItem actionBlock:(void (^)())actionBlock;

@end
