//
//  TLBadge.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLBadge.h"

#define     FONT_TITLE      [UIFont systemFontOfSize:12]
#define     EDGE_TITLE      self.frame.size.height * 0.3

@interface TLBadge ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLBadge

+ (CGSize)badgeSizeWithValue:(NSString *)value
{
    return [self badgeSizeWithValue:value font:FONT_TITLE];
}

+ (CGSize)badgeSizeWithValue:(NSString *)value font:(UIFont *)font
{
    if (!value) {
        return CGSizeZero;
    }
    if (value.length == 0) {
        return CGSizeMake(10, 10);
    }
    CGSize size = [value sizeWithAttributes:@{NSFontAttributeName : font}];
    CGFloat width = MAX(size.width + HEIGHT_BADGE * 0.6, HEIGHT_BADGE);
    return CGSizeMake(width, HEIGHT_BADGE);
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.layer setMasksToBounds:YES];
        [self setBackgroundColor:[UIColor redColor]];
        
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.layer setCornerRadius:self.frame.size.height / 2.0];
    // 更新titleLabel坐标和大小
    CGFloat height = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
    [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width - EDGE_TITLE * 2, height)];
    [self.titleLabel setCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)];
}

- (void)setValue:(id)value
{
    _value = value;
    [self.titleLabel setText:value];
    [self.titleLabel sizeToFit];
    CGSize size = [TLBadge badgeSizeWithValue:value];
    [self setFrame:CGRectMake(self.frame.origin.x,
                             self.frame.origin.y,
                             size.width,
                              size.height)];
    [self setNeedsDisplay];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    [self.titleLabel setFont:titleFont];
}
- (UIFont *)titleFont
{
    return self.titleLabel.font;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    [self.titleLabel setTextColor:titleColor];
}
- (UIColor *)titleColor
{
    return self.titleLabel.textColor;
}

#pragma mark - # Getters
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:FONT_TITLE];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

@end
