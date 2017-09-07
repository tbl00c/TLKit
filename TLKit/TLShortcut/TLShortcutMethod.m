//
//  TLShortcutMethod.c
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLShortcutMethod.h"

UILabel *createLabel(UIFont *font, UIColor *color)
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:font];
    [label setTextColor:color];
    return label;
}
