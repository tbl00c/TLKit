//
//  TLActionSheetTitleView.h
//  TLKit
//
//  Created by 李伯坤 on 2021/1/16.
//

#import <UIKit/UIKit.h>
#import <ZZFLEX/ZZFLEX.h>

@interface TLActionSheetTitleView : UIView

/// 左图标（支持UIImage, NSString, UIView）
@property (nonatomic, strong) id leftIcon;
/// 右图标（支持UIImage, NSString, UIView）
@property (nonatomic, strong) id rightIcon;
/// 标题（支持NSString, NSAttributeString, UIView）
@property (nonatomic, strong) id title;

@property (nonatomic, strong, readonly) UIImageView *leftIconView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UIImageView *rightIconView;

@property (nonatomic, assign) CGFloat spaceInset;

@end
