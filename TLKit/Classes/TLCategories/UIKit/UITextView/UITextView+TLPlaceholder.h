//
//  UITextView+TLPlaceholder.h
//  Pods
//
//  Created by 李伯坤 on 2017/9/11.
//
//

#import <UIKit/UIKit.h>

@interface UITextView (TLPlaceholder)

@property (nonatomic, strong, readonly) UITextView *placeholderTextView;

@property (nonatomic, strong) NSString *placeholder;

@end
