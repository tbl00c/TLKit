//
//  UIControl+ActionBlocks.m
//  Pods
//
//  Created by 李伯坤 on 2017/8/31.
//
//

#import "UIControl+ActionBlocks.h"
#import <objc/runtime.h>

#define ZZ_UICONTROL_EVENT(methodName, eventName) \
-(void)methodName : (void (^)(void))eventBlock \
{ \
    objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC); \
    [self addTarget:self \
             action:@selector(methodName##Action:) \
   forControlEvents:UIControlEvent##eventName]; \
}\
-(void)methodName##Action:(id)sender \
{ \
    void (^block)() = objc_getAssociatedObject(self, @selector(methodName:)); \
    if (block) { \
        block(); \
    } \
}

@implementation UIControl (ActionBlocks)

ZZ_UICONTROL_EVENT(zz_touchDown, TouchDown)
ZZ_UICONTROL_EVENT(zz_touchDownRepeat, TouchDownRepeat)
ZZ_UICONTROL_EVENT(zz_touchDragInside, TouchDragInside)
ZZ_UICONTROL_EVENT(zz_touchDragOutside, TouchDragOutside)
ZZ_UICONTROL_EVENT(zz_touchDragEnter, TouchDragEnter)
ZZ_UICONTROL_EVENT(zz_touchDragExit, TouchDragExit)
ZZ_UICONTROL_EVENT(zz_touchUpInside, TouchUpInside)
ZZ_UICONTROL_EVENT(zz_touchUpOutside, TouchUpOutside)
ZZ_UICONTROL_EVENT(zz_touchCancel, TouchCancel)
ZZ_UICONTROL_EVENT(zz_valueChanged, ValueChanged)
ZZ_UICONTROL_EVENT(zz_editingDidBegin, EditingDidBegin)
ZZ_UICONTROL_EVENT(zz_editingChanged, EditingChanged)
ZZ_UICONTROL_EVENT(zz_editingDidEnd, EditingDidEnd)
ZZ_UICONTROL_EVENT(zz_editingDidEndOnExit, EditingDidEndOnExit)

@end
