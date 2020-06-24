//
//  TLActionSheetAppearance.m
//  TLKit
//
//  Created by 李伯坤 on 2020/1/27.
//

#import "TLActionSheetAppearance.h"
#import "UIColor+TLKit.h"

@implementation TLActionSheetAppearance

+ (instancetype)appearance
{
    static TLActionSheetAppearance *appearance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearance = [[TLActionSheetAppearance alloc] init];
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
    _shadowColor = [UIColor colorShadow];
    _backgroundColor = [UIColor colorBG];
    _separatorColor = [UIColor colorSeperator];
    
    _headerTitleFont = [UIFont systemFontOfSize:13.0f];
    _headerTitleColor = [UIColor grayColor];
    
    _itemHeight = 52;
    _itemBackgroundColor = [UIColor colorContent];
    
    _itemTitleFont = [UIFont systemFontOfSize:17.0f];
    _itemTitleColor = [UIColor colorLabel];
    _destructiveItemTitleColor = [UIColor redColor];
    _cancelItemTitleColor = [UIColor colorLabel];
    
    _itemMessageFont = [UIFont systemFontOfSize:12.0f];
    _itemMessageColor = [UIColor grayColor];
    _destructiveItemMessageColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
}

@end
