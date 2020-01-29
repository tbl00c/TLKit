//
//  TLMenuItemCell.m
//  TLKit
//
//  Created by libokun on 01/29/2020.
//  Copyright (c) 2020 libokun. All rights reserved.
//

#import "TLMenuItemCell.h"

@interface TLMenuItemCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLMenuItemCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 52.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self.titleLabel setText:dataModel];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.titleLabel = self.contentView.addLabel(1)
        .font([UIFont boldSystemFontOfSize:18]).textColor([UIColor blackColor])
        .frame(CGRectMake(15, (52 - 18) / 2.0, frame.size.width - 30, 18))
        .view;
    }
    return self;
}

@end
