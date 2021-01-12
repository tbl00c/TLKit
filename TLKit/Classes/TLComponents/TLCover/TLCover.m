//
//  TLCover.m
//  TLKit
//
//  Created by libokun on 2021/1/2.
//

#import "TLCover.h"

@interface TLCover ()

@property (nonatomic, assign) CGRect sourceRect;
@property (nonatomic, assign) CGRect targetRect;

@end

@implementation TLCover
@synthesize maskView = _maskView;

- (instancetype)initWithStyle:(TLCoverStyle)style
{
    if (self = [self initWithFrame:CGRectZero]) {
        self.style = style;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.animated = YES;
        self.animatedDuration = 0.25;
        [self.maskView addSubview:self];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

- (void)setContentVC:(__kindof UIViewController *)contentVC
{
    _contentVC = contentVC;
    if (_contentVC) {
        [_contentVC.view removeFromSuperview];
    }
    _contentVC = contentVC;
    [contentVC.view removeFromSuperview];
    [self addSubview:contentVC.view];
    [self resetContentFrame];
}

- (void)setContentView:(__kindof UIView *)contentView
{
    _contentView = contentView;
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
    [contentView removeFromSuperview];
    [self addSubview:contentView];
    [self resetContentFrame];
}

- (void)resetContentFrame
{
    if (_contentVC) {
        self.frame = _contentVC.view.bounds;
        _contentVC.view.frame = self.bounds;
    }
    else if (_contentView) {
        self.frame = _contentView.bounds;
        _contentView.frame = self.bounds;
    }
}

#pragma mark - # Content显示与隐藏
- (void)_resetContentRect:(CGSize)viewSize
{
    CGSize targetSize = self.frame.size;
    CGRect sourceRect = CGRectMake(0, 0, targetSize.width, targetSize.height);
    CGRect targetRect = CGRectMake(0, 0, targetSize.width, targetSize.height);
    if (self.style == TLCoverStyleTop) {
        sourceRect.origin.y = -targetSize.height;
    }
    else if (self.style == TLCoverStyleBottom) {
        sourceRect.origin.y = viewSize.height;
        targetRect.origin.y = viewSize.height - targetSize.height;
    }
    else if (self.style == TLCoverStyleLeft) {
        sourceRect.origin.x = -targetSize.width;
    }
    else if (self.style == TLCoverStyleRight) {
        sourceRect.origin.x = viewSize.width;
        targetRect.origin.x = viewSize.width - targetSize.width;
    }
    else if (self.style == TLCoverStyleCenter) {
        targetRect.origin.x = (viewSize.width - targetSize.width) / 2.0;
        targetRect.origin.y = (viewSize.height - targetSize.height) / 2.0;
        sourceRect.origin.x = targetRect.origin.x;
        sourceRect.origin.y = targetRect.origin.y;
    }
    self.sourceRect = sourceRect;
    self.targetRect = targetRect;
}

#pragma mark - # 显示与隐藏
- (void)show
{
    [self showWithAnimated:self.animated];
}

- (void)showWithAnimated:(BOOL)animated
{
    [self showInView:nil animated:animated];
}

- (void)showInView:(__kindof UIView *)view
{
    [self showInView:view animated:self.animated];
}

- (void)showInView:(__kindof UIView *)view animated:(BOOL)animated
{
    if (self.isShowing) {
        return;
    }
    self.animated = animated;
    [self resetContentFrame];
    [self.maskView showInView:view animated:NO];
    [self _resetContentRect:self.maskView.frame.size];
    
    if (animated) {
        [self setFrame:self.sourceRect];
        self.maskView.alpha = 0;
        if (self.style == TLCoverStyleCenter) {
            self.alpha = 0;
        }
        [UIView animateWithDuration:self.animatedDuration animations:^{
            self.alpha = 1;
            self.maskView.alpha = 1;
            self.frame = self.targetRect;
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        [self setFrame:self.targetRect];
    }
}

- (void)dismiss
{
    [self dismissWithAnimated:self.animated];
}

- (void)dismissWithAnimated:(BOOL)animated
{
    void (^dismissAction)(void) = ^{
        [self.maskView dismissWithAnimated:NO];
        [self removeFromSuperview];
        self.maskView = nil;
    };
    if (animated) {
        [UIView animateWithDuration:self.animatedDuration animations:^{
            self.maskView.alpha = 0;
            if (self.style == TLCoverStyleCenter) {
                self.alpha = 0;
            }
            self.frame = self.sourceRect;
        } completion:^(BOOL finished) {
            dismissAction();
        }];
    }
    else {
        dismissAction();
    }
}

#pragma mark - # Getter
- (TLMaskView *)maskView
{
    if (!_maskView) {
        __weak typeof(self) weakSelf = self;
        TLMaskView *maskView = [[TLMaskView alloc] initWithStyle:TLMaskViewStyleTranslucent];
        [maskView setTapAction:^(TLMaskView *maskView) {
            [weakSelf dismiss];
        }];
        _maskView = maskView;
    }
    return _maskView;
}

- (BOOL)isShowing
{
    BOOL isShowing = self.maskView.isShowing;
    return isShowing;
}

@end
