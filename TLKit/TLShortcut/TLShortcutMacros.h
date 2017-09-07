//
//  TLShortcutMacros.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#ifndef TLShortcutMacros_h
#define TLShortcutMacros_h

#pragma mark - # SIZE
#define     SIZE_SCREEN                 [UIScreen mainScreen].bounds.size
#define     WIDTH_SCREEN                SIZE_SCREEN.width
#define     HEIGHT_SCREEN               SIZE_SCREEN.height
#define     HEIGHT_STATUSBAR            20.0f
#define     HEIGHT_TABBAR               49.0f
#define     HEIGHT_NAVBAR               44.0f
#define     HEIGHT_SEARCHBAR            44.0f
#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#pragma mark - # Default
/// 广播中心
#define     TLNotificationCenter        [NSNotificationCenter defaultCenter]
/// 用户自定义数据
#define     TLUserDefaults              [NSUserDefaults standardUserDefaults]
/// URL
#define     TLURL(urlString)            [NSURL URLWithString:urlString]
/// 图片
#define     TLImage(imageName)          (imageName ? [UIImage imageNamed:imageName] : nil)
#define     TLPNG(X)                    [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"png"]]
#define     TLJPG(X)                    [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"jpg"]]
/// 字符串
#define     TLNoNilString(str)          (str.length > 0 ? str : @"")
#define     TLWeakSelf(type)            __weak typeof(type) weak##type = type;
#define     TLStrongSelf(type)          __strong typeof(type) strong##type = type;
// 方法名
#define     TLSelectorName(s)           [[NSString alloc] initWithUTF8String:sel_getName(@selector(s))]
// 类名
#define     TLClassName(c)              NSStringFromClass([c class])
// 类
#define     TLClass(className)          NSClassFromString(className)
// 国际化
#define     TLLocStr(str)                 NSLocalizedString(str, nil)
// 颜色
#define     TLColor(r, g, b, a)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

// Push
#define     PushVC(vc)                  {\
    [vc setHidesBottomBarWhenPushed:YES];\
    [self.navigationController pushViewController:vc animated:YES];\
}

/// 方法交换
#define     EXCHANGE_METHOD(oldSEL,newSEL)\
Method oldMethod = class_getInstanceMethod(self, oldSEL);\
Method newMethod = class_getInstanceMethod(self, newSEL);\
method_exchangeImplementations(oldMethod, newMethod);

#pragma mark - # Thread
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
#define MAIN_BAR(block) dispatch_barrier_async(dispatch_get_main_queue(),block)

/**
 Synthsize a weak or strong reference.
 Example:
 @weakify(self)
 [self doSomething^{
    @strongify(self)
    if (!self) return;
    ...
 }];
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#param mark - # XCode
#define     XCODE_VERSION_8_LATER       __has_include(<UserNotifications/UserNotifications.h>)


#endif /* TLShortcutMacros_h */
