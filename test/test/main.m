//
//  main.m
//  test
//
//  Created by 李伯坤 on 2017/9/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "People.h"

//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
//}


int main(int argc, char * argv[])
{
    /// 测试次数
    int testCount = 100000000;
    /// 每次测试中，消息发送的执行次数
    int executeCount = 1;
    People *x = [[People alloc] init];
    People *y = nil;
    
    NSDate *date1 = [NSDate date];
    // 测试A：消息发送，sayHello为一空方法
    for (int i = 0; i < testCount; i++) {
        for (int j = 0; j < executeCount; j++) {
            [x sayHello];
        }
    }
    NSDate *date2 = [NSDate date];
    // 测试B：消息发送，对象为nil
    for (int i = 0; i < testCount; i++) {
        for (int j = 0; j < executeCount; j++) {
            [y sayHello];
        }
    }
    NSDate *date3 = [NSDate date];
    // 测试C：if判空，不执行消息发送
    for (int i = 0; i < testCount; i++) {
        if (y) {    // 执行if判断后，可避免n多条无意义语句的执行
            for (int j = 0; j < executeCount; j++) {
                [y sayHello];
            }
        }
    }
    NSDate *date4 = [NSDate date];
    
    // 打印结果
    NSLog(@"A (!= nil): %lf", [date2 timeIntervalSinceDate:date1]);
    NSLog(@"B ( = nil): %lf", [date3 timeIntervalSinceDate:date2]);
    NSLog(@"C (nil+if): %lf", [date4 timeIntervalSinceDate:date3]);
}
