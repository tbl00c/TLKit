//
//  TLCoverDemoViewController.m
//  TLKit_Example
//
//  Created by libokun on 2021/1/2.
//  Copyright © 2021 libokun. All rights reserved.
//

#import "TLCoverDemoViewController.h"
#import "TLMenuItemCell.h"
#import "TLMenuHeaderView.h"
#import <TLKit/TLCover.h>
#import "TLViewController.h"

@interface TLCoverDemoViewController ()

@end

@implementation TLCoverDemoViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"TLCover"];
    
    [self.view setBackgroundColor:RGBColor(240, 239, 245)];
    
    [self reloadTestMenu];
}

- (void)reloadTestMenu
{
    self.clear();
    
    TLViewController *textVC = [[TLViewController alloc] init];
    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:textVC];
    [vc.view setFrame:CGRectMake(0, 0, self.view.width, 500)];
    [vc.view setBackgroundColor:[UIColor orangeColor]];
    
    NSInteger sectionType = 0;
    self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
    self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"基础样式");
    self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"显示").selectedAction(^ (NSString *title) {
        TLCover *cover = [[TLCover alloc] init];
        [cover setStyle:TLCoverStyleBottom];
        [cover setContentVC:vc];
        [cover show];
    });

    [self reloadView];
}

@end
