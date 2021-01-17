//
//  TLActionSheet.m
//  TLKit
//
//  Created by 李伯坤 on 2020/1/26.
//

#import "TLActionSheet.h"
#import "TLCover.h"
#import "TLActionSheetAppearance.h"
#import <ZZFLEX/ZZFLEX.h>
#import <Masonry/Masonry.h>
#import "TLMacros.h"
#import "TLActionSheetItemCell.h"
#import "TLActionSheetTitleView.h"

#pragma mark - # TLActionSheetItem
@implementation TLActionSheetItem

- (instancetype)initWithTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction
{
    return [self initWithTitle:title message:nil clickAction:clickAction];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message clickAction:(TLActionSheetItemClickAction)clickAction
{
    return [self initWithType:TLActionSheetItemTypeNormal title:title message:message clickAction:clickAction];
}

- (instancetype)initWithType:(TLActionSheetItemType)type title:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction
{
    return [self initWithType:type title:title message:nil clickAction:clickAction];
}

- (instancetype)initWithType:(TLActionSheetItemType)type title:(NSString *)title message:(NSString *)message clickAction:(TLActionSheetItemClickAction)clickAction
{
    if (self = [super init]) {
        self.type = type;
        self.title = title;
        self.message = message;
        self.clickAction = clickAction;
    }
    return self;
}

@end

#pragma mark - # TLActionSheet
@interface TLActionSheet ()
{
    NSMutableArray *_items;
}

@property (nonatomic, strong) TLCover *cover;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TLActionSheetTitleView *titleView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZZFLEXAngel *angel;

@property (nonatomic, strong) TLActionSheetItem *cancelItem;

@end

@implementation TLActionSheet

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title items:nil];
}

- (instancetype)initWithTitle:(NSString *)title items:(NSArray<TLActionSheetItem *> *)items
{
    if (self = [self initWithFrame:CGRectZero]) {
        self.title = title;
        if (items.count > 0) {
            [_items addObjectsFromArray:items];
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _items = [[NSMutableArray alloc] init];
        _cancelItem = [[TLActionSheetItem alloc] initWithTitle:@"取消" clickAction:nil];
        _cover = [[TLCover alloc] initWithStyle:TLCoverStyleBottom];
        [_cover setContentView:self];
        
        [self _initActionSheet];
    }
    return self;
}

- (void)_initActionSheet
{
    [self setFrame:CGRectMake(0, 0, 300, 400)];
    [self setBackgroundColor:[UIColor orangeColor]];
    return;
    @weakify(self);
    TLActionSheetAppearance *appearance = [TLActionSheetAppearance appearance];
    
    // header
    self.headerView = self.addView(1)
    .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
        make.left.right.top.height.mas_equalTo(0);
    })
    .view;
    self.titleView = [[TLActionSheetTitleView alloc] init];
    
    // 底部按钮
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        edgeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    }
    self.cancelButton = self.addButton(2)
    .contentHorizontalAlignment(UIControlContentHorizontalAlignmentCenter)
    .titleEdgeInsets(UIEdgeInsetsMake(0, 0, edgeInsets.bottom, 0))
    .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(appearance.itemHeight + edgeInsets.bottom);
    })
    .eventTouchUpInside(^ (UIButton *sender) {
        @strongify(self);
        [self dismiss];
        if (self.cancelItem.clickAction) {
            self.cancelItem.clickAction(self, self.cancelItem, self.items.count);
        }
    })
    .view;
    
    // 按钮列表
    self.collectionView = self.addCollectionView(3)
    .backgroundColor([UIColor clearColor]).scrollsToTop(NO).scrollEnabled(NO)
    .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.cancelButton.mas_top);
    })
    .view;
    self.angel = [[ZZFLEXAngel alloc] initWithHostView:self.collectionView];
}

#pragma mark - # API
- (void)setTitle:(id)title
{
    _title = title;
    return;
    
    // 清空已有headerView
    while (self.headerView.subviews.count > 0) {
        [self.headerView.subviews.firstObject removeFromSuperview];
    }
    if (title == nil) {
        [self.headerView setHidden:YES];
        return;
    }
    [self.headerView setHidden:NO];
    
    if ([self.title isKindOfClass:[UIView class]]) {
        UIView *view = self.title;
        [view removeFromSuperview];
        [self.headerView addSubview:view];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.height.mas_equalTo(self.headerView);
        }];
    }
    else if (self.title) {
        [self.headerView addSubview:self.titleView];
        [self.titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.width.mas_lessThanOrEqualTo(self.headerView).mas_offset(-SPACE_TITLE_LEFT * 2);
            make.top.mas_equalTo(SPACE_TITLE_TOP);
            make.bottom.mas_equalTo(-SPACE_TITLE_TOP);
        }];
    }
}

- (void)addItemWithTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction
{
    [self addItemWithTitle:title message:nil clickAction:clickAction];
}

- (void)addItemWithTitle:(NSString *)title message:(NSString *)message clickAction:(TLActionSheetItemClickAction)clickAction;
{
    TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithTitle:title message:message clickAction:clickAction];
    [self addItem:item];
}

- (void)setCancelItemTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction;
{
    [self.cancelItem setTitle:title];
    [self.cancelItem setClickAction:clickAction];
}

- (void)addDestructiveItemWithTitle:(NSString *)title clickAction:(TLActionSheetItemClickAction)clickAction
{
    TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithType:TLActionSheetItemTypeDestructive title:title message:nil clickAction:clickAction];
    [self addItem:item];
}

- (void)addCustomViewItem:(UIView *)customView clickAction:(TLActionSheetItemClickAction)clickAction
{
    TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithType:TLActionSheetItemTypeCustom title:nil clickAction:clickAction];
    [item setCustomView:customView];
    [self addItem:item];
}

- (void)addItem:(TLActionSheetItem *)item
{
    [_items addObject:item];
}

- (void)show
{
    [self showInView:nil];
}

- (void)showInView:(UIView *)view
{
    [self _reloadActionSheet];
    [self layoutIfNeeded];
    
    [self.cover showInView:view];
}

- (void)dismiss
{
    [self.cover dismiss];
}
 
#pragma mark - # Private
- (void)_reloadActionSheet
{
    return;
    TLActionSheetAppearance *appearance = [TLActionSheetAppearance appearance];
    [self setBackgroundColor:appearance.backgroundColor];
    
    // headers
    {
        [self.titleView.titleLabel setTextColor:self.titleColor ? self.titleColor : appearance.headerTitleColor];
        [self.titleView.titleLabel setFont:self.titleFont ? self.titleFont : appearance.headerTitleFont];
        [self.titleView.titleLabel setText:self.title];
    }
    
    // items
    {
        CGFloat height = 0;
        for (TLActionSheetItem *item in self.items) {
            height += [TLActionSheetItemCell viewHeightByDataModel:item];
        }
        [self.collectionView setScrollEnabled:NO];
        if (height > MAX_TABLEVIEW_HEIGHT) {
            height = MAX_TABLEVIEW_HEIGHT;
            [self.collectionView setScrollEnabled:YES];
        }
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        self.angel.clear();
        NSInteger sectionType = 1;
        self.angel.addSection(sectionType);
        self.angel.addCells([TLActionSheetItemCell class]).toSection(sectionType).withDataModelArray(self.items);
        [self.collectionView reloadData];
    }
    
    // button
    self.cancelButton.zz_setup.title(self.cancelItem.title).backgroundColor(appearance.itemBackgroundColor).titleColor(appearance.cancelItemTitleColor).titleFont(appearance.itemTitleFont).backgroundImageHL([self _imageWithColor:appearance.separatorColor]);
    
    // 圆角
    {
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:(CGSize){10}];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bezierPath.CGPath;
        self.layer.mask = shapeLayer;
    }
}

- (UIImage *)_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == self.items.count) {
        return self.cancelItem.title;
    }
    else if (buttonIndex < self.items.count) {
        TLActionSheetItem *item = [self.items objectAtIndex:buttonIndex];
        return item.title;
    }
    return nil;
}

#pragma mark - # 旧版本兼容
- (id)initWithTitle:(NSString *)title clickAction:(void (^)(NSInteger buttonIndex))clickAction cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    [self setClickAction:clickAction];
    [self setCancelItemTitle:cancelButtonTitle clickAction:nil];
    if (self = [self initWithTitle:title]) {
        __weak typeof(self) weakSelf = self;
        TLActionSheetItemClickAction clickAction = ^(TLActionSheet *actionSheet, TLActionSheetItem *item, NSInteger index) {
            if (weakSelf.clickAction) {
                weakSelf.clickAction(index);
            }
        };
        
        if (otherButtonTitles) {
            va_list list;
            va_start(list, otherButtonTitles);
            if (otherButtonTitles) {
                [self addItemWithTitle:otherButtonTitles clickAction:clickAction];
            }
            NSString *title = va_arg(list, id);
            while (title.length > 0) {
                [self addItemWithTitle:title clickAction:clickAction];
                title = va_arg(list, id);
            }
            va_end(list);
        }
       
        if (destructiveButtonTitle.length > 0) {
            [self addDestructiveItemWithTitle:destructiveButtonTitle clickAction:clickAction];
        }
    }
    
    return self;
}

@end
