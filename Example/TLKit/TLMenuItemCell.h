//
//  TLMenuItemCell.m
//  TLKit
//
//  Created by libokun on 01/29/2020.
//  Copyright (c) 2020 libokun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLMenuItem : NSObject

@property (nonatomic, strong) NSString *title;

@end

@interface TLMenuItemCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLMenuItem *menuItem;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) id (^viewEventAction)(NSInteger, id);

@end
