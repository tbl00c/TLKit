//
//  People.m
//  test
//
//  Created by 李伯坤 on 2017/9/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "People.h"

//@interface People : NSObject
//
//- (People *(^)(NSString *sth))eat;
//
//@end

@implementation People

- (People *(^)(NSString *sth))eat
{
    return ^(NSString *sth) {
        NSLog(@"I eat %@", sth);
        return self;
    };
}

@end

