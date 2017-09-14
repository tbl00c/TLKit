//
//  TLTabBarController.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLTabBarController.h"
#import "TLTabBar.h"
#import "UIImage+Color.h"

@interface TLTabBarController ()

@property (nonatomic, strong) TLTabBar *tlTabBar;

@end

@implementation TLTabBarController

- (void)loadView
{
    [super loadView];

    [self.tabBar addSubview:self.tlTabBar];
}

- (void)addChildViewController:(UIViewController *)viewController
{
    [self addChildViewController:viewController actionBlock:nil];
}

- (void)addChildViewController:(UIViewController *)viewController actionBlock:(BOOL (^)())actionBlock
{
    [super addChildViewController:viewController];
    if ([viewController isKindOfClass:[UINavigationController class]] && viewController.childViewControllers.count > 0) {
        [self.tlTabBar addTabBarItemWithSystemTabBarItem:viewController.childViewControllers.firstObject.tabBarItem actionBlock:actionBlock];
    }
    else {
        [self.tlTabBar addTabBarItemWithSystemTabBarItem:viewController.tabBarItem actionBlock:actionBlock];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self p_removeAllSystemControl];
    });
}

- (void)addPlusItemWithSystemTabBarItem:(UITabBarItem *)systemTabBarItem actionBlock:(void (^)())actionBlock
{
    [super addChildViewController:[[UIViewController alloc] init]];
    [self.tlTabBar addPlusItemWithSystemTabBarItem:systemTabBarItem actionBlock:^BOOL{
        actionBlock();
        return NO;
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self p_removeAllSystemControl];
    });
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self.tlTabBar setSelectedIndex:selectedIndex];
}

#pragma mark - # Private Methods
// 移除系统控件
- (void)p_removeAllSystemControl
{
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj setHidden:YES];
        }
    }];
}

#pragma mark - # Getters
- (TLTabBar *)tlTabBar
{
    if (!_tlTabBar) {
        _tlTabBar = [[TLTabBar alloc] initWithSystemTabBar:self.tabBar];
        __weak typeof(self) weakSelf = self;
        [_tlTabBar setDidSelectItemAtIndex:^(NSInteger index){
            if (index >= weakSelf.viewControllers.count) {
                return;
            }
            if (index == weakSelf.selectedIndex) {
                UIViewController<TLTabBarControllerProtocol> *vc = weakSelf.viewControllers[index];
                if ([vc respondsToSelector:@selector(tabBarItemDidClick)]) {
                    [vc tabBarItemDidClick];
                }
                else if ([vc isKindOfClass:[UINavigationController class]] && vc.childViewControllers.count > 0) {
                    vc = vc.childViewControllers.firstObject;
                    if ([vc respondsToSelector:@selector(tabBarItemDidClick)]) {
                        [vc tabBarItemDidClick];
                    }
                }
            }
            else {
                [weakSelf setSelectedIndex:index];
            }
        }];
        [_tlTabBar setDidDoubleClickItemAtIndex:^(NSInteger index){
            if (index >= weakSelf.viewControllers.count) {
                return;
            }
            if (index == weakSelf.selectedIndex) {
                UIViewController<TLTabBarControllerProtocol> *vc = weakSelf.viewControllers[index];
                if ([vc respondsToSelector:@selector(tabBarItemDidDoubleClick)]) {
                    [vc tabBarItemDidDoubleClick];
                }
                else if ([vc isKindOfClass:[UINavigationController class]] && vc.childViewControllers.count > 0) {
                    vc = vc.childViewControllers.firstObject;
                    if ([vc respondsToSelector:@selector(tabBarItemDidDoubleClick)]) {
                        [vc tabBarItemDidDoubleClick];
                    }
                }
            }
            else {
                [weakSelf setSelectedIndex:index];
            }
        }];
    }
    return _tlTabBar;
}

@end


#pragma mark - ## UITabBar (TLExtension)
@implementation UITabBar (TLExtension)

- (void)setHiddenShadow:(BOOL)hiddenShadow
{
    if (self.barTintColor) {
        [self setBackgroundImage:[UIImage imageWithColor:self.barTintColor]];
    }
    else {
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0]]];
    }
    if (hiddenShadow) {
        [self setShadowImage:[UIImage new]];
    }
    else {
        [self setShadowImage:nil];
    }
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    [self setHiddenShadow:NO];
    if (shadowColor) {
        [self setShadowImage:[UIImage imageWithColor:shadowColor]];
    }
    else {
        [self setShadowImage:[UIImage new]];
    }
}

@end
