//
//  TLTabBarItem.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTabBarItem : UIButton

@property (nonatomic, copy) void (^clickActionBlock)();

@property (nonatomic, copy) void (^didChangedTabBarItem)();

- (id)initWithSystemTabBarItem:(UITabBarItem *)systemTabBarItem clickActionBlock:(void (^)())clickActionBlock;

@end
