//
//  TLMenuSwitchItemCell.m
//  TLKit_Example
//
//  Created by libokun on 2021/1/13.
//  Copyright © 2021 libokun. All rights reserved.
//

#import "TLMenuSwitchItemCell.h"

@implementation TLMenuSwitchItem

+ (instancetype)createWithTitle:(NSString *)title on:(BOOL)on
{
    TLMenuSwitchItem *item = [[TLMenuSwitchItem alloc] init];
    item.title = title;
    item.on = on;
    return item;
}

@end

@implementation TLMenuSwitchItemCell

- (void)setViewDataModel:(TLMenuSwitchItem *)dataModel
{
    [super setViewDataModel:dataModel];
    [self.switchControl setOn:dataModel.on];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        @weakify(self);
        self.switchControl = self.contentView.addSwitch(1)
        .masonry(^(__kindof UIView *view, MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        })
        .eventBlock(UIControlEventValueChanged, ^(UISwitch *sender) {
            @strongify(self);
            [(TLMenuSwitchItem *)self.menuItem setOn:sender.on];
            if (self.viewEventAction) {
                self.viewEventAction(0, @(sender.on));
            }
        })
        .view;
    }
    return self;
}


@end
