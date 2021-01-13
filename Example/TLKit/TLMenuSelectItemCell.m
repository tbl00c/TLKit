//
//  TLMenuSelectItemCell.m
//  TLKit_Example
//
//  Created by libokun on 2021/1/13.
//  Copyright © 2021 libokun. All rights reserved.
//

#import "TLMenuSelectItemCell.h"

@implementation TLMenuSelectItem

+ (instancetype)createWithTitle:(NSString *)title menuItems:(NSArray *)menuItems
{
    TLMenuSelectItem *item = [[TLMenuSelectItem alloc] init];
    item.title = title;
    item.menuItems = menuItems;
    return item;
}

@end

@implementation TLMenuSelectItemCell

- (void)setViewDataModel:(TLMenuSelectItem *)dataModel
{
    [super setViewDataModel:dataModel];
    
    [self.segmentControl removeAllSegments];
    [dataModel.menuItems enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.segmentControl insertSegmentWithTitle:obj atIndex:idx animated:NO];
    }];
    [self.segmentControl setSelectedSegmentIndex:dataModel.selectedIndex];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        @weakify(self);
        self.segmentControl = [[UISegmentedControl alloc] init];
        [self.contentView addSubview:self.segmentControl];
        [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_greaterThanOrEqualTo(self.titleLabel.mas_right).mas_offset(15);
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        }];
        self.segmentControl.zz_setup.eventBlock(UIControlEventValueChanged, ^(id sender) {
            @strongify(self);
            if (self.viewEventAction) {
                self.viewEventAction(0, @(self.segmentControl.selectedSegmentIndex));
            }
        });
    }
    return self;
}

@end
