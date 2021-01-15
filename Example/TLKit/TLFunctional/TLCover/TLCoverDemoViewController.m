//
//  TLCoverDemoViewController.m
//  TLKit_Example
//
//  Created by libokun on 2021/1/2.
//  Copyright © 2021 libokun. All rights reserved.
//

#import "TLCoverDemoViewController.h"
#import "TLMenuItemCell.h"
#import "TLMenuSelectItemCell.h"
#import "TLMenuSwitchItemCell.h"
#import "TLMenuCenterItemCell.h"
#import "TLMenuHeaderView.h"
#import <TLKit/TLCover.h>
#import "TLViewController.h"

@interface TLCoverDemoViewController ()

@property (nonatomic, assign) TLCoverStyle coverStyle;
@property (nonatomic, assign) TLMaskViewStyle maskStyle;
@property (nonatomic, assign) BOOL tapDisable;
@property (nonatomic, assign) BOOL animatedDisable;
@property (nonatomic, assign) NSInteger superType;

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
    @weakify(self)
    self.clear();
    
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 20, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"样式设置");
        
        {
            TLMenuSelectItem *item = [TLMenuSelectItem createWithTitle:@"风格" menuItems:@[@"底", @"左", @"右", @"上", @"中"]];
            item.selectedIndex = self.coverStyle;
            self.addCell([TLMenuSelectItemCell class]).toSection(sectionType).withDataModel(item).eventAction(^ id(NSInteger type, NSNumber *index) {
                @strongify(self);
                self.coverStyle = index.integerValue;
                return nil;
            });
        }
        
        {
            TLMenuSelectItem *item = [TLMenuSelectItem createWithTitle:@"父视图" menuItems:@[@"nil", @"self.view", @"self.nav", @"keyWindow"]];
            item.selectedIndex = self.superType;
            self.addCell([TLMenuSelectItemCell class]).toSection(sectionType).withDataModel(item).eventAction(^ id(NSInteger type, NSNumber *index) {
                @strongify(self);
                self.superType = index.integerValue;
                return nil;
            });
        }
        
        {
            TLMenuSelectItem *item = [TLMenuSelectItem createWithTitle:@"遮罩风格" menuItems:@[@"半透明", @"全透明", @"毛玻璃"]];
            item.selectedIndex = self.maskStyle;
            self.addCell([TLMenuSelectItemCell class]).toSection(sectionType).withDataModel(item).eventAction(^ id(NSInteger type, NSNumber *index) {
                @strongify(self);
                self.maskStyle = index.integerValue;
                return nil;
            });
        }
        
        {
            TLMenuSwitchItem *item = [TLMenuSwitchItem createWithTitle:@"禁用背景点击" on:self.tapDisable];
            self.addCell([TLMenuSwitchItemCell class]).toSection(sectionType).withDataModel(item).eventAction(^ id(NSInteger type, NSNumber *index) {
                @strongify(self);
                self.tapDisable = index.boolValue;
                return nil;
            });
        }
        
        {
            TLMenuSwitchItem *item = [TLMenuSwitchItem createWithTitle:@"禁用动画" on:self.animatedDisable];
            self.addCell([TLMenuSwitchItemCell class]).toSection(sectionType).withDataModel(item).eventAction(^ id(NSInteger type, NSNumber *index) {
                @strongify(self);
                self.animatedDisable = index.boolValue;
                return nil;
            });
        }
    }
    
    
    TLViewController *textVC = [[TLViewController alloc] init];
    UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:textVC];
    
    NSInteger sectionType = 1;
    self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 20, 0));
    self.addCell([TLMenuCenterItemCell class]).toSection(sectionType).withDataModel(@"显示").selectedAction(^ (NSString *title) {
        @strongify(self);
        CGFloat width = self.superType == 1 ? self.view.width : [UIScreen mainScreen].bounds.size.width;
        CGFloat height = self.superType == 1 ? self.view.height : [UIScreen mainScreen].bounds.size.height;
        if (self.coverStyle == TLCoverStyleLeft || self.coverStyle == TLCoverStyleRight || self.coverStyle == TLCoverStyleCenter) {
            width = width * 0.75;
        }
        if (self.coverStyle == TLCoverStyleTop || self.coverStyle == TLCoverStyleBottom || self.coverStyle == TLCoverStyleCenter) {
            height = height * 0.65;
        }
        [vc.view setFrame:CGRectMake(0, 0, width, height)];
        
        TLCover *cover = [[TLCover alloc] initWithStyle:self.coverStyle];
        cover.maskView.style = self.maskStyle;
        cover.maskView.disableTapEvent = self.tapDisable;
        [cover setContentVC:vc];
        
        __kindof UIView *view;
        if (self.superType == 1) {
            view = self.view;
        }
        else if (self.superType == 2) {
            view = self.navigationController.view;
        }
        else if (self.superType == 3) {
            view = [UIApplication sharedApplication].keyWindow;
        }
        [cover showInView:view animated:!self.animatedDisable];
    });

    [self reloadView];
}

@end
