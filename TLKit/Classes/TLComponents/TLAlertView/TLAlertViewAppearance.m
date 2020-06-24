//
//  TLAlertViewAppearance.m
//  TLKit
//
//  Created by 李伯坤 on 2020/1/28.
//

#import "TLAlertViewAppearance.h"
#import "UIColor+TLKit.h"

@implementation TLAlertViewAppearance

+ (instancetype)appearance
{
    static TLAlertViewAppearance *appearance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearance = [[TLAlertViewAppearance alloc] init];
    });
    return appearance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self resetData];
    }
    return self;
}

- (void)resetData
{
    _cornerRadius = 8.0f;
    _shadowColor = [UIColor colorShadow];
    _backgroundColor = [UIColor colorContent];
    _separatorColor = [UIColor colorSeperator];
    
    _titleFont = [UIFont boldSystemFontOfSize:17.0f];
    _titleColor = [UIColor colorLabel];
    _itemTitleColorDisable = [UIColor lightGrayColor];
    
    _messageFont = [UIFont systemFontOfSize:17.0f];
    _messageColor = [UIColor grayColor];
    
    _viewWidth = 320;
    _itemHeight = 52;
    _minViewHeight = 160;
    
    _itemTitleFont = [UIFont boldSystemFontOfSize:17.0f];
    _itemTitleColor = [UIColor colorBlue];
    _destructiveItemTitleColor = [UIColor colorRed];
    _cancelItemTitleColor = [UIColor colorLabel];
}

@end
