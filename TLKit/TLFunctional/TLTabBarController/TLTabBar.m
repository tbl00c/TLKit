//
//  TLTabBar.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLTabBar.h"
#import "TLTabBarItem.h"

@interface TLTabBar ()

@property (nonatomic, weak) UITabBar *systemTabBar;

@property (nonatomic, strong, readonly) NSMutableArray *tabBarItems;

@end

@implementation TLTabBar
@synthesize tabBarItems = _tabBarItems;

- (id)initWithSystemTabBar:(UITabBar *)systemTabBar
{
    if (self = [super initWithFrame:systemTabBar.bounds]) {
        [self setSystemTabBar:systemTabBar];
    }
    return self;
}

- (void)dealloc
{
    [self.systemTabBar removeObserver:self forKeyPath:@"tintColor"];
}

#pragma mark - # Public Methods
- (void)addTabBarItemWithSystemTabBarItem:(UITabBarItem *)systemTabBarItem
{
    TLTabBarItem *tabBarItem = [[TLTabBarItem alloc] initWithSystemTabBarItem:systemTabBarItem];
    [tabBarItem setTintColor:self.systemTabBar.tintColor];
    [tabBarItem addTarget:self action:@selector(tabBarItemTouchDown:) forControlEvents:UIControlEventTouchDown];
    [tabBarItem addTarget:self action:@selector(tabBarItemTouchDownRepeat:) forControlEvents:UIControlEventTouchDownRepeat];
    __weak typeof(self) weakSelf = self;
    [tabBarItem setDidChangedTabBarItem:^{
        [weakSelf.systemTabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
            if ([obj isKindOfClass:[UIControl class]]) {
                [obj removeFromSuperview];
            }
        }];
    }];
    
    // 选中、添加到数组
    if (self.tabBarItems.count == 0) {
        [tabBarItem setSelected:YES];
    }
    [self.tabBarItems addObject:tabBarItem];
    // 更新UI
    [self addSubview:tabBarItem];
    [self p_resetTabBarItemFrames];
}

- (void)setSystemTabBar:(UITabBar *)systemTabBar
{
    _systemTabBar = systemTabBar;
    [systemTabBar addObserver:self forKeyPath:@"tintColor" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - # Event Response
- (void)tabBarItemTouchDown:(TLTabBarItem *)sender
{
    if (sender.isSelected) {
        [self performSelector:@selector(tabBarItemClick:) withObject:sender afterDelay:0.2];
    }
    else {
        [sender setUserInteractionEnabled:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [sender setUserInteractionEnabled:YES];
        });
        [self tabBarItemClick:sender];
    }
}

- (void)tabBarItemClick:(TLTabBarItem *)sender
{
    if (self.didSelectItemAtIndex) {
        self.didSelectItemAtIndex([self.tabBarItems indexOfObject:sender]);
    }
    for (TLTabBarItem *item in self.tabBarItems) {
        [item setSelected:(item == sender)];
    }
}

- (void)tabBarItemTouchDownRepeat:(TLTabBarItem *)sender
{
    [sender setUserInteractionEnabled:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender setUserInteractionEnabled:YES];
    });
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tabBarItemClick:) object:sender];
    
    if (!sender.isSelected) {
        [self tabBarItemClick:sender];
    }
    else {
        if (self.didDoubleClickItemAtIndex) {
            self.didDoubleClickItemAtIndex([self.tabBarItems indexOfObject:sender]);
        }
    }
}

#pragma mark - # Private Methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object != self.systemTabBar) {
        return;
    }
    
    if ([keyPath isEqualToString:@"tintColor"]) {
        for (TLTabBarItem *item in self.tabBarItems) {
            [item setTintColor:self.systemTabBar.tintColor];
        }
    }
}

- (void)p_resetTabBarItemFrames
{
    CGFloat width = self.frame.size.width / self.tabBarItems.count;
    CGFloat x = 0;
    for (TLTabBarItem *tabBarItem in self.tabBarItems) {
        [tabBarItem setFrame:CGRectMake(x + width * 0.05, 0, width * 0.9, self.frame.size.height)];
        x += width;
    }
}

#pragma mark - # Getters
- (NSMutableArray *)tabBarItems
{
    if (!_tabBarItems) {
        _tabBarItems = [[NSMutableArray alloc] init];
    }
    return _tabBarItems;
}

@end
