//
//  TLMenuHeaderView.m
//  TLKit_Example
//
//  Created by 李伯坤 on 2020/1/29.
//  Copyright © 2020 libokun. All rights reserved.
//

#import "TLMenuHeaderView.h"

@interface TLMenuHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLMenuHeaderView

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 42.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self.titleLabel setText:dataModel];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.titleLabel = self.addLabel(1)
        .font([UIFont boldSystemFontOfSize:14]).textColor([UIColor grayColor])
        .frame(CGRectMake(15, (52 - 18) / 2.0, frame.size.width - 30, 18))
        .view;
    }
    return self;
}

@end
