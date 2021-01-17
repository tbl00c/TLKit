//
//  TLActionSheet.h
//  TLKit
//
//  Created by 李伯坤 on 2020/1/26.
//

/*
 自定义ActionSheet
 
 无任何依赖，可直接独立使用
 */

#import <UIKit/UIKit.h>

#pragma mark - # TLActionSheetItem
@class TLActionSheet;
@class TLActionSheetItem;
typedef void (^TLActionSheetItemClickAction)(TLActionSheet *actionSheet, TLActionSheetItem *item, NSInteger index);
typedef void (^TLActionSheetItemConfigAction)(TLActionSheet *actionSheet, __kindof UIView *view, TLActionSheetItem *item, NSInteger index);
typedef NS_ENUM(NSInteger, TLActionSheetItemType) {
    TLActionSheetItemTypeNormal = 0,
    TLActionSheetItemTypeCancel = 1,
    TLActionSheetItemTypeDestructive = 2,
    TLActionSheetItemTypeCustom = 3,
};

@interface TLActionSheetItem : NSObject

/// 类型
@property (nonatomic, assign) TLActionSheetItemType type;

/// 左侧图标（支持NSString、UIImage, UIView）
@property (nonatomic, strong) id leftIcon;
/// 标题（支持NSString、NSAttributeString、UIImage, UIView）
@property (nonatomic, strong) id title;
/// 右侧图标（支持NSString、UIImage, UIView）
@property (nonatomic, strong) id rightIcon;

/// 副标题（支持NSString、NSAttributeString, UIView）
@property (nonatomic, strong) id message;

/// 点击事件
@property (nonatomic, copy) TLActionSheetItemClickAction clickAction;

/// 自定义类型
@property (nonatomic, strong) UIView *customView;

@property (nonatomic, copy) TLActionSheetItemConfigAction configAction;

#pragma mark - 自定义项
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIFont *messageFont;

- (instancetype)initWithTitle:(id)title clickAction:(TLActionSheetItemClickAction)clickAction;
- (instancetype)initWithTitle:(id)title message:(id)message clickAction:(TLActionSheetItemClickAction)clickAction;
- (instancetype)initWithType:(TLActionSheetItemType)type title:(id)title clickAction:(TLActionSheetItemClickAction)clickAction;
- (instancetype)initWithType:(TLActionSheetItemType)type title:(id)title message:(id)message clickAction:(TLActionSheetItemClickAction)clickAction;

@end

#pragma mark - # TLActionSheet
@interface TLActionSheet : UIView

/// 标题 (支持NSString、NSAttributeString、UIView)
@property (nonatomic, strong) id title;

/// 按钮（不包含取消按钮）
@property (nonatomic, strong, readonly) NSArray<TLActionSheetItem *> *items;

- (instancetype)initWithTitle:(id)title;
- (instancetype)initWithTitle:(id)title items:(NSArray<TLActionSheetItem *> *)items;

- (void)addItem:(TLActionSheetItem *)item;

- (void)addItemWithTitle:(id)title clickAction:(TLActionSheetItemClickAction)clickAction;
- (void)addItemWithTitle:(id)title message:(id)message clickAction:(TLActionSheetItemClickAction)clickAction;
- (void)addDestructiveItemWithTitle:(id)title clickAction:(TLActionSheetItemClickAction)clickAction;
- (void)addCustomViewItem:(UIView *)customView clickAction:(TLActionSheetItemClickAction)clickAction;

- (void)setCancelItemTitle:(id)title clickAction:(TLActionSheetItemClickAction)clickAction;

- (void)show;
- (void)dismiss;

/**
 *  根据index获取按钮标题
 *
 *  @param  buttonIndex     按钮index
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

#pragma mark - 自定义项
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;

#pragma mark - # 旧版本兼容
/// 点击事件响应block
@property (nonatomic, copy) void (^clickAction)(NSInteger buttonIndex);

- (id)initWithTitle:(NSString *)title
        clickAction:(void (^)(NSInteger buttonIndex))clickAction
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
