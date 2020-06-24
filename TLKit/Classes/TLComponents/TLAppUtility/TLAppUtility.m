//
//  TLAppUtility.m
//  TLKit
//
//  Created by 李伯坤 on 2020/4/27.
//

#import "TLAppUtility.h"
#import <sys/utsname.h>

@implementation TLAppUtility

+ (NSString *)appName
{
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    return appName;
}

+ (NSString *)bundleId
{
    NSString *bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    return bundleId;
}

+ (NSString *)totalBundleId
{
    NSString *totalBundleId = [NSString stringWithFormat:@"%@.%@", [self codeSignIn], self.bundleId];
    return totalBundleId;
}

+ (NSString *)version
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return version;
}

+ (UIImage *)appIcon
{
    NSString *iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"];
    NSString *iconBasename = [iconFilename stringByDeletingPathExtension];
    NSString *iconExtension = [iconFilename pathExtension];
    NSString *iconPath = [[NSBundle mainBundle] pathForResource:iconBasename ofType:iconExtension];
    UIImage *appIcon = [[UIImage alloc] initWithContentsOfFile:iconPath];
    return appIcon;
}

+ (NSString *)codeSignIn
{
    NSString *embeddedPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];

    if ([[NSFileManager defaultManager] fileExistsAtPath:embeddedPath]) {
        NSString *embeddedProvisioning = [NSString stringWithContentsOfFile:embeddedPath encoding:NSASCIIStringEncoding error:nil];
        NSArray *embeddedProvisioningLines = [embeddedProvisioning componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        for (int i = 0; i < [embeddedProvisioningLines count]; i++) {
            if ([[embeddedProvisioningLines objectAtIndex:i] rangeOfString:@"application-identifier"].location != NSNotFound) {
                NSInteger fromPosition = [[embeddedProvisioningLines objectAtIndex:i+1] rangeOfString:@"<string>"].location+8;
                NSInteger toPosition = [[embeddedProvisioningLines objectAtIndex:i+1] rangeOfString:@"</string>"].location;
                
                NSRange range = NSMakeRange(fromPosition, toPosition - fromPosition);
                NSString *fullIdentifier = [[embeddedProvisioningLines objectAtIndex:i+1] substringWithRange:range];
                NSString *appIdentifier = [[fullIdentifier componentsSeparatedByString:@"."] firstObject];
                return appIdentifier;
            }
        }
    }
    return nil;
}

+ (NSString *)device
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}



@end
