//
//  TLViewController.m
//  TLKit
//
//  Created by libokun on 01/29/2020.
//  Copyright (c) 2020 libokun. All rights reserved.
//

#import "TLViewController.h"
#import "TLMenuHeaderView.h"
#import "TLMenuItemCell.h"

#import "TLMaskViewDemoViewController.h"
#import "TLCoverDemoViewController.h"
#import "TLActionSheetDemoViewController.h"
#import "TLAlertViewDemoViewController.h"
#import "TLToastDemoViewController.h"

@interface TLViewController ()

@end

@implementation TLViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"TLDemo"];
    [self.view setBackgroundColor:RGBColor(240, 239, 245)];
    
    [self reloadTestMenu];
}

- (void)reloadTestMenu
{
    @weakify(self);
    self.clear();
    
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType);
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"TLComponents");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"TLMaskView").selectedAction(^ (NSString *title) {
            @strongify(self);
            TLMaskViewDemoViewController *vc = [[TLMaskViewDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"TLCover").selectedAction(^ (NSString *title) {
            @strongify(self);
            TLCoverDemoViewController *vc = [[TLCoverDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"TLAlertView").selectedAction(^ (NSString *title) {
            @strongify(self);
            TLAlertViewDemoViewController *vc = [[TLAlertViewDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"TLActionSheet").selectedAction(^ (NSString *title) {
            @strongify(self);
            TLActionSheetDemoViewController *vc = [[TLActionSheetDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"TLToast").selectedAction(^ (NSString *title) {
            @strongify(self);
            TLToastDemoViewController *vc = [[TLToastDemoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        });
    }
    
    [self reloadView];
}

@end
