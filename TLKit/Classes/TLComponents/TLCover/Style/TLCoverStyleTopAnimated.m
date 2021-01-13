//
//  TLCoverStyleTopAnimated.m
//  TLKit
//
//  Created by libokun on 2021/1/14.
//

#import "TLCoverStyleTopAnimated.h"
#import <Masonry/Masonry.h>
#import "TLMacros.h"

@implementation TLCoverStyleTopAnimated

- (void)show:(TLCover *)cover contentView:(UIView *)contentView animated:(BOOL)animated willShowAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))willShowAction didShowAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))didShowAction
{
    // 动画前
    CGSize size = contentView.frame.size;
    if (willShowAction) {
        willShowAction(self);
    }
    if (animated) {
        cover.maskView.alpha = 0;
        [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(cover.mas_top  );
            make.size.mas_equalTo(size);
        }];
        [cover layoutIfNeeded];
    }
    
    // 动画
    [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(size);
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
    CGSize size = contentView.frame.size;
    if (willDismissAction) {
        willDismissAction(self);
    }
    [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(cover.mas_top);
        make.size.mas_equalTo(size);
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
