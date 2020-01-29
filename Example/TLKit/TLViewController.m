//
//  TLViewController.m
//  TLKit
//
//  Created by libokun on 01/29/2020.
//  Copyright (c) 2020 libokun. All rights reserved.
//

#import "TLViewController.h"
#import "TLMenuItemCell.h"

@interface TLViewController ()

@end

@implementation TLViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"TLDemo"];
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0 / 255.0 green:239.0 / 255.0 blue:245.0 / 1.0 alpha:1.0]];
    
    [self reloadTestMenu];
}

- (void)reloadTestMenu
{
    self.clear();
    
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"请添加调试项").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:title message:nil];
            [alertView show];
        });
    }
    
    [self reloadView];
}

@end
