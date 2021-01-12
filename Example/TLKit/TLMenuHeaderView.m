//
//  TLMenuHeaderView.m
//  TLKit_Example
//
//  Created by 李伯坤 on 2020/1/29.
//  Copyright © 2020 libokun. All rights reserved.
//

#import "TLMenuHeaderView.h"

@interface TLMenuHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLMenuHeaderView

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 42.0f;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat left = 15;
    CGFloat right = -15;
    if (@available(iOS 11.0, *)) {
        left += self.safeAreaInsets.left;
        right -= self.safeAreaInsets.right;
    }
    if (self.titleLabel.left != left) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.right.mas_lessThanOrEqualTo(right);
        }];
    }
}

- (void)setViewDataModel:(id)dataModel
{
    [self.titleLabel setText:dataModel];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        CGFloat left = 15;
        CGFloat right = -15;
        if (@available(iOS 11.0, *)) {
            left += self.safeAreaInsets.left;
            right -= self.safeAreaInsets.right;
        }
        self.titleLabel = self.addLabel(1)
        .font([UIFont boldSystemFontOfSize:14]).textColor([UIColor grayColor])
        .masonry(^ (UIView *sender, MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.centerY.mas_equalTo(0);
            make.right.mas_lessThanOrEqualTo(right);
        })
        .view;
    }
    return self;
}

@end
