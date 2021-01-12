//
//  TLMenuSwitchItemCell.h
//  TLKit_Example
//
//  Created by libokun on 2021/1/13.
//  Copyright © 2021 libokun. All rights reserved.
//

#import "TLMenuItemCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLMenuSwitchItem : TLMenuItem

@property (nonatomic, assign) BOOL on;

+ (instancetype)createWithTitle:(NSString *)title on:(BOOL)on;

@end

@interface TLMenuSwitchItemCell : TLMenuItemCell

@property (nonatomic, strong) UISwitch *switchControl;

@end

NS_ASSUME_NONNULL_END
