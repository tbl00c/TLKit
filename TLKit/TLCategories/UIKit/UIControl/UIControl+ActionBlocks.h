//
//  UIControl+ActionBlocks.h
//  Pods
//
//  Created by 李伯坤 on 2017/8/31.
//
//

#import <UIKit/UIKit.h>

@interface UIControl (ActionBlocks)

- (void)zz_touchDown:(void (^)(void))eventBlock;
- (void)zz_touchDownRepeat:(void (^)(void))eventBlock;
- (void)zz_touchDragInside:(void (^)(void))eventBlock;
- (void)zz_touchDragOutside:(void (^)(void))eventBlock;
- (void)zz_touchDragEnter:(void (^)(void))eventBlock;
- (void)zz_touchDragExit:(void (^)(void))eventBlock;
- (void)zz_touchUpInside:(void (^)(void))eventBlock;
- (void)zz_touchUpOutside:(void (^)(void))eventBlock;
- (void)zz_touchCancel:(void (^)(void))eventBlock;
- (void)zz_valueChanged:(void (^)(void))eventBlock;
- (void)zz_editingDidBegin:(void (^)(void))eventBlock;
- (void)zz_editingChanged:(void (^)(void))eventBlock;
- (void)zz_editingDidEnd:(void (^)(void))eventBlock;
- (void)zz_editingDidEndOnExit:(void (^)(void))eventBlock;

@end
