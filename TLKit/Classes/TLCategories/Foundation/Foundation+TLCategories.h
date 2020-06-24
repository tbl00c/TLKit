//
//  Foundation+TLCategories.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#ifndef Foundation_TLCategories_h
#define Foundation_TLCategories_h

//MAKR: NSObject
#import "NSObject+TLAssociation.h"            // NSObject 利用runtime动态添加属性（支持strong）
#import "NSObject+TLEasyCopy.h"               // NSObject 快捷copy、深copy
#import "NSObject+TLKVOBlock.h"               // NSObject KVO
#import "NSObject+TLReflection.h"             // NSObject 获取类关系

//MARK: NSString
#import "NSString+TLContains.h"               // NSString 包含Emoji、空格等判断
#import "NSString+TLNormalRegex.h"            // NSString 常用正则匹配
#import "NSString+TLSize.h"                   // NSString 计算字符串大小
#import "NSString+TLURL.h"                    // NSString URL编码、解码相关
#import "NSString+TLBase64.h"                 // NSString Base64编解码
#import "NSString+TLHash.h"                   // NSString Md5、sha1等hash计算
#import "NSString+TLEncrypt.h"                // NSString AES、Des等加解密
#import "NSString+TLPinYin.h"                 // NSString 获取汉字拼音
#import "NSString+TLStringPages.h"            // NSString 对字符串进行分页

//MARK: NSData
#import "NSData+TLBase64.h"                   // NSData Base64编解码
#import "NSData+TLEncrypt.h"                  // NSData AES、Des等加解密
#import "NSData+TLGzip.h"                     // NSData Gzip
#import "NSData+TLHash.h"                     // NSData Md5、sha1等hash计算

//MARK: NSArray
#import "NSArray+TLSafeAccess.h"              // NSArray 数组安全取值、类型取值等

//MARK: NSMutableArray
#import "NSMutableArray+TLSafeAccess.h"       // NSMutableArray 安全添加值、类型添加值等

//MARK: NSDictionary
#import "NSDictionary+TLExtensions.h"         // NSDictionary 合并字典等
#import "NSDictionary+TLSafeAccess.h"         // NSDictionary 安全取值、类型取值等

//MARK: NSMutableDictionary
#import "NSMutableDictionary+TLSafeAccess.h"  // NSMutableDictionary 安全添加值、类型添加值等

//MARK: NSURL
#import "NSURL+TLParams.h"                    // NSURL 获取url中的参数等

//MARK: NSDate
#import "NSDate+TLExtensions.h"               // NSDate 时间日期快速获取
#import "NSDate+TLRelation.h"                 // DSDate 时间关系

//MARK: NSTimer
#import "NSTimer+TLBlock.h"                   // NSTimer 定时器

//MARK: NSFileManager
#import "NSFileManager+TLPaths.h"             // NSFileManager 常用文件路径等

//MARK: NSNotificationCenter
#import "NSNotificationCenter+TLMainThread.h" // NSNotificationCenter 主线程发送广播

//MARK: NSBundle
#import "NSBundle+TLAppIcon.h"                // NSBundle 获取AppIcon等


#endif /* Foundation_TLCategories_h */
