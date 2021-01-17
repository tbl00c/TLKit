//
//  TLActionSheetItemCell.m
//  TLKit
//
//  Created by 李伯坤 on 2021/1/16.
//

#import "TLActionSheetItemCell.h"
#import "TLActionSheetAppearance.h"
#import "TLActionSheet.h"
#import <Masonry/Masonry.h>
#import "TLActionSheetTitleView.h"

@interface TLActionSheetItemCell ()

@property (nonatomic, strong) TLActionSheetTitleView *titleView;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *customView;

@end

@implementation TLActionSheetItemCell

+ (CGFloat)viewHeightByDataModel:(TLActionSheetItem *)dataModel
{
    if (dataModel.type == TLActionSheetItemTypeCustom) {
        return dataModel.customView.frame.size.height;
    }
    TLActionSheetAppearance *appearance = [TLActionSheetAppearance appearance];
    CGFloat height = appearance.itemHeight;
    if (dataModel.message) {
        height += 6;
    }
    return height;
}

- (void)setViewDataModel:(TLActionSheetItem *)dataModel
{
    [self setItem:dataModel];
}

- (void)onViewPositionUpdatedWithIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == count - 1) {
        self.removeSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom).color([TLActionSheetAppearance appearance].separatorColor);
    }
}

#pragma mark - # Life
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSelectedBackgroundView:[UIView new]];
        
        self.titleView = [[TLActionSheetTitleView alloc] init];
        [self.contentView addSubview:self.titleView];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SPACE_MIDDEL);
            make.centerX.mas_equalTo(0);
            make.width.mas_lessThanOrEqualTo(self).mas_offset(-SPACE_TITLE_LEFT * 2);
        }];
        
        self.messageLabel = self.contentView.addLabel(2).numberOfLines(0)
        .masonry(^ (__kindof UIView *view, MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleView.mas_bottom).mas_offset(SPACE_MIDDEL);
            make.centerX.mas_equalTo(0);
            make.width.mas_lessThanOrEqualTo(self).mas_offset(-SPACE_TITLE_LEFT * 2);
        })
        .view;
    }
    return self;
}

- (void)setItem:(TLActionSheetItem *)item
{
    _item = item;
    
    TLActionSheetAppearance *appearance = [TLActionSheetAppearance appearance];
    [self setBackgroundColor:item.backgroundColor ? item.backgroundColor : appearance.itemBackgroundColor];
    [self.selectedBackgroundView setBackgroundColor:item.selectedBackgroundColor ? item.selectedBackgroundColor : appearance.separatorColor];
    
    [self.customView removeFromSuperview];
    if (item.type == TLActionSheetItemTypeCustom) {
        self.titleView.hidden = self.messageLabel.hidden = YES;
        self.customView = item.customView;
        [self.contentView addSubview:self.customView];
        [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_lessThanOrEqualTo(self);
        }];
        return;
    }
    
    self.titleView.titleLabel.zz_setup.hidden(NO).text(item.title).font(item.titleFont ? item.titleFont : appearance.itemTitleFont);
    self.messageLabel.zz_setup.hidden(NO).text(item.message).font(item.messageFont ? item.messageFont : appearance.itemMessageFont);
    if (item.type == TLActionSheetItemTypeNormal) {
        [self.titleView.titleLabel setTextColor:item.titleColor ? item.titleColor : appearance.itemTitleColor];
        if (item.message) {
            [self.messageLabel setTextColor:item.messageColor ? item.messageColor : appearance.itemMessageColor];
        }
    }
    else if (item.type == TLActionSheetItemTypeDestructive) {
        [self.titleView.titleLabel setTextColor:item.titleColor ? item.titleColor : appearance.destructiveItemTitleColor];;
        if (item.message) {
            [self.messageLabel setTextColor:item.messageColor ? item.messageColor : appearance.destructiveItemMessageColor];
        }
    }
}

@end
