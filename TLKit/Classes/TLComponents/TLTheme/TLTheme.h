//
//  TLTheme.h
//  TLKit
//
//  Created by 李伯坤 on 2020/4/26.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TLThemeStyle) {
    TLThemeStyleLight = 0,
    TLThemeStyleDark = 1,
};

@class TLTheme;
typedef void (^TLThemeStyleChangedAction)(TLTheme *theme, TLThemeStyle style, TLThemeStyle lastStyle);

@interface TLTheme : NSObject

/// 遵循
@property (nonatomic, assign) BOOL obeySystemSetting;
@property (nonatomic, assign) TLThemeStyle themeStyle;


+ (instancetype)sharedInstance;

- (BOOL)addThemeStyleChangedObserver:(TLThemeStyleChangedAction)changeAction forKey:(NSString *)key;

- (BOOL)removeObserverForKey:(NSString *)key;

@end
