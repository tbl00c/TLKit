//
//  TLMenuItemCell.m
//  TLKit
//
//  Created by libokun on 01/29/2020.
//  Copyright (c) 2020 libokun. All rights reserved.
//

#import "TLMenuItemCell.h"

@implementation TLMenuItem

@end

@implementation TLMenuItemCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(-1, 52.0f);
}

- (void)setViewDataModel:(id)dataModel
{
    _menuItem = dataModel;
    if ([dataModel isKindOfClass:[NSString class]]) {
        [self.titleLabel setText:dataModel];
    }
    else if ([dataModel isKindOfClass:[TLMenuItem class]]) {
        [self.titleLabel setText:[(TLMenuItem *)dataModel title]];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (@available(iOS 11.0, *)) {
        if (self.safeAreaInsets.left != self.contentView.left) {
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(self.safeAreaInsets.left);
                make.right.mas_equalTo(-self.safeAreaInsets.right);
            }];
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat left = 15;
        if (@available(iOS 11.0, *)) {
            left += self.safeAreaInsets.left;
        }
        self.titleLabel = self.contentView.addLabel(1)
        .font([UIFont boldSystemFontOfSize:18]).textColor([UIColor blackColor])
        .masonry(^(__kindof UIView *view, MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
