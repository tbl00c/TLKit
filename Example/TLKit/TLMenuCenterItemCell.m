//
//  TLMenuCenterItemCell.m
//  TLKit_Example
//
//  Created by libokun on 2021/1/13.
//  Copyright © 2021 libokun. All rights reserved.
//

#import "TLMenuCenterItemCell.h"

@implementation TLMenuCenterItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.mas_equalTo(0);
        }];
    }
    return self;
}


@end
