//
//  UITabBarController+TLTabBarHidden.h
//  LCGO
//
//  Created by lbk on 2018/3/22.
//  Copyright © 2018年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TLTabBarHidden)

@property (nonatomic, assign, readonly) BOOL tabBarIsVisible;

- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated completion:(void (^)(BOOL))completion;

@end
