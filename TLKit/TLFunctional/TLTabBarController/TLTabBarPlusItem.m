//
//  TLTabBarPlusItem.m
//  Pods
//
//  Created by 李伯坤 on 2017/9/14.
//
//

#import "TLTabBarPlusItem.h"

@implementation TLTabBarPlusItem

- (id)initWithSystemTabBarItem:(UITabBarItem *)systemTabBarItem clickActionBlock:(BOOL (^)())clickActionBlock
{
    if (self = [super initWithSystemTabBarItem:systemTabBarItem clickActionBlock:clickActionBlock]) {
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return self;
}

@end
