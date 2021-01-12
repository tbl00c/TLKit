//
//  TLMenuSelectItemCell.h
//  TLKit_Example
//
//  Created by libokun on 2021/1/13.
//  Copyright © 2021 libokun. All rights reserved.
//

#import "TLMenuItemCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TLMenuSelectItem : TLMenuItem

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, assign) NSInteger selectedIndex;

+ (instancetype)createWithTitle:(NSString *)title menuItems:(NSArray *)menuItems;

@end

@interface TLMenuSelectItemCell : TLMenuItemCell

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@end

NS_ASSUME_NONNULL_END
