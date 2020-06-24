//
//  TLTheme.m
//  TLKit
//
//  Created by 李伯坤 on 2020/4/26.
//

#import "TLTheme.h"

@interface TLThemeObserver : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, copy) TLThemeStyleChangedAction action;

@end

@implementation TLThemeObserver

+ (instancetype)createWithKey:(NSString *)key action:(TLThemeStyleChangedAction)action
{
    TLThemeObserver *observer = [[TLThemeObserver alloc] init];
    observer.action = action;
    return observer;
}

@end

@interface TLTheme ()

@property (nonatomic, strong) NSMutableDictionary *observerMap;
@property (nonatomic, strong) NSMutableArray *observerList;

@end

@implementation TLTheme
{
    TLThemeStyle __themeStyle;
    NSInteger __obeySystemSetting;
}

+ (instancetype)sharedInstance
{
    static TLTheme *theme;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theme = [[TLTheme alloc] init];
    });
    return theme;
}

- (instancetype)init
{
    if (self = [super init]) {
        _observerMap = [[NSMutableDictionary alloc] init];
        _observerList = [[NSMutableArray alloc] init];
        __obeySystemSetting = __themeStyle = -1;
    }
    return self;
}

- (void)setObeySystemSetting:(BOOL)obeySystemSetting
{
    TLThemeStyle lastStyle = [self themeStyle];
    __obeySystemSetting = obeySystemSetting;
    [[NSUserDefaults standardUserDefaults] setObject:@(obeySystemSetting) forKey:@"tt_themeObeySystem"];
    [self themeStyleChanged:[self themeStyle] lastStyle:lastStyle];
}
- (BOOL)obeySystemSetting
{
    if (__obeySystemSetting == -1) {
        NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"tt_themeObeySystem"];
        __obeySystemSetting = number ? [number boolValue] : YES;
    }
    return __obeySystemSetting != 0;
}

- (void)setThemeStyle:(TLThemeStyle)themeStyle
{
    TLThemeStyle lastStyle = __themeStyle;
    __themeStyle = themeStyle;
    [[NSUserDefaults standardUserDefaults] setObject:@(themeStyle) forKey:@"tt_themeStyle"];
    [self themeStyleChanged:themeStyle lastStyle:lastStyle];
}

- (TLThemeStyle)themeStyle
{
    if (self.obeySystemSetting) {
        if (@available(iOS 12.0, *)) {
            if ([UIApplication sharedApplication].keyWindow.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return TLThemeStyleDark;
            }
        }
        return TLThemeStyleLight;
    }
    if (__themeStyle == -1) {
        __themeStyle = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tt_themeStyle"] integerValue];
    }
    return __themeStyle;
}

- (void)themeStyleChanged:(TLThemeStyle)style lastStyle:(TLThemeStyle)latStyle
{
    if (style == latStyle) {
        return;
    }
    
//    if (@available(iOS 13.0, *)) {
//        UIUserInterfaceStyle sysStyle = [self overrideInterfaceStyleByThemeStyle:style];
//        for (UIWindow *window in [UIApplication sharedApplication].windows) {
//            window.overrideUserInterfaceStyle = sysStyle;
//        }
//    }
    
    for (TLThemeObserver *observer in self.observerList) {
        if (observer.action) {
            observer.action(self, style, latStyle);
        }
    }
}

- (UIUserInterfaceStyle)overrideInterfaceStyleByThemeStyle:(TLThemeStyle)style API_AVAILABLE(ios(12.0))
{
    switch (style) {
//        case TLThemeStyleDefault:
//            return UIUserInterfaceStyleUnspecified;
        case TLThemeStyleDark:
            return UIUserInterfaceStyleDark;
        case TLThemeStyleLight:
            return UIUserInterfaceStyleLight;
    }
    return 0;
}

- (BOOL)addThemeStyleChangedObserver:(TLThemeStyleChangedAction)changeAction forKey:(NSString *)key
{
    if (!changeAction || !key) {
        return NO;
    }
    TLThemeObserver *observer = [TLThemeObserver createWithKey:key action:changeAction];
    [self.observerMap setObject:observer forKey:key];
    [self.observerList addObject:observer];
    return YES;
}

- (BOOL)removeObserverForKey:(NSString *)key
{
    if (!key) {
        return NO;
    }
    TLThemeObserver *observer = [self.observerMap objectForKey:key];
    if (observer) {
        [self.observerList removeObject:observer];
        [self.observerMap removeObjectForKey:key];
    }
    return YES;
}

@end
