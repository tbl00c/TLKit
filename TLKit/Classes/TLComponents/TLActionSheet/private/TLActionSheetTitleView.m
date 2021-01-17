//
//  TLActionSheetTitleView.m
//  TLKit
//
//  Created by 李伯坤 on 2021/1/16.
//

#import "TLActionSheetTitleView.h"
#import <Masonry/Masonry.h>
#import <ZZFLEX/ZZFLEX.h>

@implementation TLActionSheetTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _spaceInset = 5;
        
        _titleLabel = self.addLabel(1003)
        .textAlignment(NSTextAlignmentCenter)
        .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.top.mas_greaterThanOrEqualTo(self);
            make.bottom.mas_lessThanOrEqualTo(self);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        })
        .view;
        
        _leftIconView = self.addImageView(1001)
        .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.top.mas_greaterThanOrEqualTo(self);
            make.bottom.mas_lessThanOrEqualTo(self);
            make.left.mas_equalTo(0);
        })
        .view;
        
        _rightIconView = self.addImageView(1002)
        .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.top.mas_greaterThanOrEqualTo(self);
            make.bottom.mas_lessThanOrEqualTo(self);
            make.right.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

- (void)setLeftIcon:(id)leftIcon
{
    _leftIcon = leftIcon;
    if ([leftIcon isKindOfClass:[NSString class]]) {
        [self.leftIconView setImage:[UIImage imageNamed:leftIcon]];
    }
    else if ([leftIcon isKindOfClass:[UIImage class]]) {
        [self.leftIconView setImage:leftIcon];
    }
    else if ([leftIcon isKindOfClass:[UIView class]]) {
        UIView *view = leftIcon;
        [view removeFromSuperview];
        [self.leftIconView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    [self _updateTitleViewUI];
}

- (void)setRightIcon:(id)rightIcon
{
    _rightIcon = rightIcon;
    if ([rightIcon isKindOfClass:[NSString class]]) {
        [self.rightIconView setImage:[UIImage imageNamed:rightIcon]];
    }
    else if ([rightIcon isKindOfClass:[UIImage class]]) {
        [self.rightIconView setImage:rightIcon];
    }
    else if ([rightIcon isKindOfClass:[UIView class]]) {
        UIView *view = rightIcon;
        [view removeFromSuperview];
        [self.rightIconView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    [self _updateTitleViewUI];
}

- (void)_updateTitleViewUI
{
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_greaterThanOrEqualTo(self);
        make.bottom.mas_lessThanOrEqualTo(self);
        if (self.leftIcon) {
            make.left.mas_equalTo(self.leftIconView.mas_right).mas_offset(self.spaceInset);
        }
        else {
            make.left.mas_equalTo(0);
        }
        if (self.rightIcon) {
            make.right.mas_equalTo(self.rightIconView.mas_right).mas_offset(-self.spaceInset);
        }
        else {
            make.right.mas_equalTo(0);
        }
    }];
}

- (void)setTitle:(id)title
{
    _title = title;
    if ([title isKindOfClass:[NSAttributedString class]]) {
        [self.titleLabel setAttributedText:title];
    }
    else if ([title isKindOfClass:[NSString class]]) {
        [self.titleLabel setText:title];
    }
    else if ([title isKindOfClass:[UIImage class]]) {
        UIImage *image = title;
        NSAttributedString *attrTitle = NSMutableAttributedString.zz_create(@"").appendImage(image, CGRectMake(0, 0, image.size.width, image.size.height)).object;
        [self.titleLabel setAttributedText:attrTitle];
    }
    else if ([title isKindOfClass:[UIView class]]) {
        UIView *view = title;
        [view removeFromSuperview];
        [self.titleLabel addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
}

@end
