//
//  TLBadge.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

#define     HEIGHT_BADGE        18.0f

@interface TLBadge : UIView

@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

+ (CGSize)badgeSizeWithValue:(NSString *)value;
+ (CGSize)badgeSizeWithValue:(NSString *)value font:(UIFont *)font;

@end
