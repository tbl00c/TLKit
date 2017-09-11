//
//  UIViewController+NavBar.m
//  Pods
//
//  Created by 李伯坤 on 2017/9/11.
//
//

#import "UIViewController+NavBar.h"
#import "JZNavigationExtension.h"

@implementation UIViewController (NavBar)

#pragma mark - # Hidden/Show NavBar
- (void)setNeedHideNavigationBar:(BOOL)needHideNavigationBar
{
    self.jz_wantsNavigationBarVisible = !needHideNavigationBar;
}
- (BOOL)needHideNavigationBar
{
    return !self.jz_wantsNavigationBarVisible;
}

@end
