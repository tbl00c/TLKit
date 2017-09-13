//
//  TLTabBarItem.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLTabBarItem.h"
#import "UIImage+Color.h"
#import "TLBadge.h"

#define     HEIGHT_REDPOINT     10

#pragma mark - ## TLTabBarItem
@interface TLTabBarItem ()

@property (nonatomic, strong) UITabBarItem *systemTabBarItem;

@property (nonatomic, strong) TLBadge *badge;

@end

@implementation TLTabBarItem

- (id)initWithSystemTabBarItem:(UITabBarItem *)systemTabBarItem
{
    if (self = [super initWithFrame:systemTabBarItem.accessibilityFrame]) {
        [self.imageView setContentMode:UIViewContentModeCenter];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [self setSystemTabBarItem:systemTabBarItem];
        [self addSubview:self.badge];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.badge.value isEqualToString:@""]) {       // 红点
        CGFloat x = self.frame.size.width / 2 + 9;
        [self.badge setFrame:CGRectMake(x, 5, self.badge.frame.size.width, self.badge.frame.size.height)];
    }
    else if (self.badge.value.length > 0) {             // 气泡（带内容）
        CGSize size = self.badge.frame.size;
        CGFloat x = self.frame.size.width / 2 + 7;
        CGFloat width = MIN(self.frame.size.width * 1.3 - x, size.width);
        [self.badge setFrame:CGRectMake(x, 3, width, size.height)];
    }
}

- (void)dealloc
{
    [self.systemTabBarItem removeObserver:self forKeyPath:@"badgeValue"];
    [self.systemTabBarItem removeObserver:self forKeyPath:@"title"];
    [self.systemTabBarItem removeObserver:self forKeyPath:@"image"];
    [self.systemTabBarItem removeObserver:self forKeyPath:@"selectedImage"];
}

#pragma mark - # Public Methods
- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    [self setImage:[self.systemTabBarItem.selectedImage imageWithColor:tintColor] forState:UIControlStateSelected];
    [self setTitleColor:tintColor forState:UIControlStateSelected];
}

#pragma mark - # Private Methods
- (void)setSystemTabBarItem:(UITabBarItem *)systemTabBarItem
{
    _systemTabBarItem = systemTabBarItem;
    [systemTabBarItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [systemTabBarItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [systemTabBarItem addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [systemTabBarItem addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    [self setNeedsDisplay];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{    
    [self setTitle:self.systemTabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.systemTabBarItem.image forState:UIControlStateNormal];
    if (self.systemTabBarItem.selectedImage) {
        [self setImage:[self.systemTabBarItem.selectedImage imageWithColor:self.tintColor] forState:UIControlStateSelected];
    }
    else {
        [self setImage:[self.systemTabBarItem.image imageWithColor:self.tintColor] forState:UIControlStateSelected];
    }
    
    if (self.systemTabBarItem.badgeValue) {
        [self.badge setHidden:NO];
        [self.badge setValue:self.systemTabBarItem.badgeValue];
    }
    else {
        [self.badge setHidden:YES];
    }
    
    if (self.didChangedTabBarItem) {
        self.didChangedTabBarItem();
    }
}

/// 图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat y = 3;
    CGFloat height = contentRect.size.height - 15 - y;
    return CGRectMake(0, y, contentRect.size.width, height);
}

/// 标题位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat height = 15;
    CGFloat y = contentRect.size.height - height;
    return CGRectMake(0, y, contentRect.size.width, height);
}

/// 不响应高亮态
- (void)setHighlighted:(BOOL)highlighted {}

#pragma mark - # Getters
- (TLBadge *)badge
{
    if (!_badge) {
        _badge = [[TLBadge alloc] init];
    }
    return _badge;
}

@end
