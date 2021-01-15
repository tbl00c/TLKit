//
//  TLCoverStyleCenterAnimated.m
//  TLKit
//
//  Created by libokun on 2021/1/14.
//

#import "TLCoverStyleCenterAnimated.h"
#import <Masonry/Masonry.h>
#import "TLMacros.h"

@implementation TLCoverStyleCenterAnimated

- (void)show:(TLCover *)cover contentView:(UIView *)contentView animated:(BOOL)animated willShowAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))willShowAction didShowAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))didShowAction
{
    // 动画前
    CGSize size = contentView.frame.size;
    if (willShowAction) {
        willShowAction(self);
    }
    [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(size);
    }];
    [cover layoutIfNeeded];
    if (animated) {
        cover.maskView.alpha = 0;
    }
    
    if (animated) {
        [UIView animateWithDuration:cover.animatedDuration animations:^{
            cover.maskView.alpha = 1;
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
    if (animated) {
        [UIView animateWithDuration:cover.animatedDuration animations:^{
            cover.maskView.alpha = 0;
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
