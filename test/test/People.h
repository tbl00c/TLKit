//
//  People.h
//  test
//
//  Created by 李伯坤 on 2017/9/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject

- (People *(^)(NSString *sth))eat;

- (void)sayHello;

@end
