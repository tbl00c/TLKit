//
//  UITextView+TLSelect.h
//  Pods
//
//  Created by 李伯坤 on 2017/9/11.
//
//

#import <UIKit/UIKit.h>

@interface UITextView (TLSelect)

/**
 * 当前选中的字符串范围
 */
- (NSRange)selectedRange;

/**
 *  选中所有文字
 */
- (void)selectedText;

/**
 *  选中指定范围的文字
 */
- (void)setSelectedRange:(NSRange)range;

@end
