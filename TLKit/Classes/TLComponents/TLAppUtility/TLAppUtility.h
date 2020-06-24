//
//  TLAppUtility.h
//  TLKit
//
//  Created by 李伯坤 on 2020/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLAppUtility : NSObject

+ (NSString *)appName;
+ (UIImage *)appIcon;
+ (NSString *)version;

+ (NSString *)bundleId;
+ (NSString *)codeSignIn;
+ (NSString *)totalBundleId;

+ (NSString *)device;

@end

NS_ASSUME_NONNULL_END
