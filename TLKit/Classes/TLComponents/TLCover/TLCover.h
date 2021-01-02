//
//  TLCover.h
//  TLKit
//
//  Created by libokun on 2021/1/2.
//

#import <UIKit/UIKit.h>
#import "TLMaskView.h"

typedef NS_ENUM(NSInteger, TLCoverStyle) {
    TLCoverStyleBottom = 0,     // 显示在底部
    TLCoverStyleLeft = 1,       // 显示在左侧
    TLCoverStyleRight = 2,      // 显示在右侧
    TLCoverStyleTop = 3,        // 显示在上面
    TLCoverStyleCenter = 4,     // 显示在中间
//    TLCoverStyleUserDefine = 5, // 用户自定义
};

@interface TLCover : UIView

@property (nonatomic, strong) __kindof UIView *contentView;
@property (nonatomic, strong) __kindof UIViewController *contentVC;

@property (nonatomic, assign) CGFloat animatedDuration;

/// 背景遮罩视图
@property (nonatomic, strong, readonly) TLMaskView *maskView;

/// cover风格
@property (nonatomic, assign) TLCoverStyle style;

/// 是否正在显示
@property (nonatomic, assign, readonly) BOOL isShowing;

- (void)show;
- (void)showWithAnimated:(BOOL)animated;

- (void)showInView:(__kindof UIView *)view;
- (void)showInView:(__kindof UIView *)view animated:(BOOL)animated;

- (void)dismiss;
- (void)dismissWithAnimated:(BOOL)animated;

@end
