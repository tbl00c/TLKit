//
//  TLCoverStyleRightAnimated.m
//  TLKit
//
//  Created by libokun on 2021/1/14.
//

#import "TLCoverStyleRightAnimated.h"
#import <Masonry/Masonry.h>
#import "TLMacros.h"

@implementation TLCoverStyleRightAnimated

- (void)show:(TLCover *)cover contentView:(UIView *)contentView animated:(BOOL)animated willShowAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))willShowAction didShowAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))didShowAction
{
    // 动画前
    CGSize size = contentView.frame.size;
    if (willShowAction) {
        willShowAction(self);
    }
    if (animated) {
        cover.maskView.alpha = 0;
        [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cover.edgeInsets.top);
            make.bottom.mas_equalTo(-cover.edgeInsets.bottom);
            make.left.mas_equalTo(cover.mas_right);
            make.width.mas_equalTo(size.width);
        }];
        [cover layoutIfNeeded];
    }
    
    // 动画
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cover.mas_right).mas_offset(-size.width - cover.edgeInsets.left);;
    }];
    
    if (animated) {
        [UIView animateWithDuration:cover.animatedDuration animations:^{
            cover.maskView.alpha = 1;
            [cover layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (didShowAction) {
                didShowAction(self);
            }
        }];
    }
    else {
        [cover layoutIfNeeded];
        if (didShowAction) {
            didShowAction(self);
        }
    }
}

- (void)dismiss:(TLCover *)cover contentView:(UIView *)contentView animated:(BOOL)animated willDismissAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))willDismissAction didDismissAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))didDismissAction
{
    if (willDismissAction) {
        willDismissAction(self);
    }
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cover.mas_right);
    }];
    
    if (animated) {
        [UIView animateWithDuration:cover.animatedDuration animations:^{
            cover.maskView.alpha = 0;
            [cover layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (didDismissAction) {
                didDismissAction(self);
            }
        }];
    }
    else {
        [cover layoutIfNeeded];
        if (didDismissAction) {
            didDismissAction(self);
        }
    }
}

@end
