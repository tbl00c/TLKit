//
//  TLMaskView.h
//  TLKit
//
//  Created by libokun on 2021/1/1.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLMaskViewStyle) {
    TLMaskViewStyleTranslucent = 0,       // 半透明灰色背景
    TLMaskViewStyleTransparent = 1,       // 全透明背景
    TLMaskViewStyleBlur = 2,              // 毛玻璃背景
};

@interface TLMaskView : UIControl

@property (nonatomic, assign) TLMaskViewStyle style;

/// 动画时长，默认0.2
@property (nonatomic, assign) CGFloat animationDuration;
/// 是否正在显示
@property (nonatomic, assign, readonly) BOOL isShowing;
/// 禁用背景点击事件
@property (nonatomic, assign) BOOL disableTapEvent;
/// 自定义背景点击事件（实现后，不会再触发dismiss）
@property (nonatomic, copy) void (^tapAction)(TLMaskView *maskView);
/// 动画
@property (nonatomic, assign) BOOL animated;

- (instancetype)initWithStyle:(TLMaskViewStyle)style;

- (void)show;
- (void)showWithAnimated:(BOOL)animated;

- (void)showInView:(__kindof UIView *)view;
- (void)showInView:(__kindof UIView *)view animated:(BOOL)animated;

- (void)dismiss;
- (void)dismissWithAnimated:(BOOL)animated;

@end
