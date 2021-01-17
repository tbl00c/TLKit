//
//  TLCover.m
//  TLKit
//
//  Created by libokun on 2021/1/2.
//

#import "TLCover.h"
#import "TLMacros.h"
#import <Masonry/Masonry.h>

#import "TLCoverStyleTopAnimated.h"
#import "TLCoverStyleBottomAnimated.h"
#import "TLCoverStyleLeftAnimated.h"
#import "TLCoverStyleRightAnimated.h"
#import "TLCoverStyleCenterAnimated.h"

#pragma mark - ## TLCover
@interface TLCover ()

@property (nonatomic, strong) UIView *realContentView;
@property (nonatomic, strong) NSObject<ITLCoverStyleAnimated> *styleAnimated;
@property (nonatomic, weak, readonly) NSObject<ITLCoverStyleAnimated> *realStyleAnimated;
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
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [self addSubview:self.realContentView];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *subView in self.subviews) {
        CGPoint sp = [self convertPoint:point toView:subView];
        UIView *view = [subView hitTest:sp withEvent:event];
        if (view) {
            return view                         ;
        }
    }
    return self.maskView;
}

- (void)setContentVC:(__kindof UIViewController *)contentVC
{
    _contentVC = contentVC;
    if (_contentVC) {
        [_contentVC.view removeFromSuperview];
    }
    _contentVC = contentVC;
    [self.realContentView addSubview:contentVC.view];
    [self.realContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(contentVC.view);
    }];
    [self layoutIfNeeded];
}

- (void)setContentView:(__kindof UIView *)contentView
{
    _contentView = contentView;
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
    [self.realContentView addSubview:contentView];
    [self.realContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(contentView);
    }];
    [self layoutIfNeeded];
}

- (void)setStyle:(TLCoverStyle)style
{
    _style = style;
    _styleAnimated = nil;
    if (_style == TLCoverStyleBottom) {
        _styleAnimated = [[TLCoverStyleBottomAnimated alloc] init];
    }
    else if (style == TLCoverStyleTop) {
        _styleAnimated = [[TLCoverStyleTopAnimated alloc] init];
    }
    else if (style == TLCoverStyleLeft) {
        _styleAnimated = [[TLCoverStyleLeftAnimated alloc] init];
    }
    else if (style == TLCoverStyleRight) {
        _styleAnimated = [[TLCoverStyleRightAnimated alloc] init];
    }
    else if (style == TLCoverStyleCenter) {
        _styleAnimated = [[TLCoverStyleCenterAnimated alloc] init];
    }
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
    [self.maskView showInView:view animated:NO];
    [self.styleAnimated show:self contentView:self.realContentView animated:animated willShowAction:^(NSObject<ITLCoverStyleAnimated> *styleAnimated) {
        
    } didShowAction:^(NSObject<ITLCoverStyleAnimated> *styleAnimated) {
        
    }];
}

- (void)dismiss
{
    [self dismissWithAnimated:self.animated];
}

- (void)dismissWithAnimated:(BOOL)animated
{
    @weakify(self);
    [self.styleAnimated dismiss:self contentView:self.realContentView animated:animated willDismissAction:^(NSObject<ITLCoverStyleAnimated> *styleAnimated) {
            
    } didDismissAction:^(NSObject<ITLCoverStyleAnimated> *styleAnimated) {
        @strongify(self);
        [self.maskView dismissWithAnimated:NO];
        [self removeFromSuperview];
        self.maskView = nil;
    }];
}

#pragma mark - # Getter
- (UIView *)realContentView
{
    if (!_realContentView) {
        _realContentView = [[UIView alloc] init];
        [_realContentView setBackgroundColor:[UIColor clearColor]];
    }
    return _realContentView;
}

- (NSObject<ITLCoverStyleAnimated> *)realStyleAnimated
{
    if (self.style == TLCoverStyleUserDefine) {
        return self.userDefineStyleAnimated;
    }
    return self.styleAnimated;
}

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
