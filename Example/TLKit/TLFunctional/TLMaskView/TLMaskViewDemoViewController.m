//
//  TLMaskViewDemoViewController.m
//  TLKit_Example
//
//  Created by libokun on 2021/1/2.
//  Copyright © 2021 libokun. All rights reserved.
//

#import "TLMaskViewDemoViewController.h"
#import "TLMenuItemCell.h"
#import "TLMenuSelectItemCell.h"
#import "TLMenuSwitchItemCell.h"
#import "TLMenuCenterItemCell.h"
#import "TLMenuHeaderView.h"
#import <TLKit/TLMaskView.h>

@interface TLMaskViewDemoViewController ()

@property (nonatomic, assign) TLMaskViewStyle maskStyle;
@property (nonatomic, assign) BOOL tapDisable;
@property (nonatomic, assign) BOOL animatedDisable;
@property (nonatomic, assign) NSInteger superType;

@end

@implementation TLMaskViewDemoViewController

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
    
    void (^addButton)(TLMaskView *view) = ^(TLMaskView *view) {
        @weakify(view);
        view.addButton(1).backgroundColor([UIColor redColor]).title(@"关闭")
        .titleFont([UIFont boldSystemFontOfSize:22]).titleColor([UIColor whiteColor])
        .cornerRadius(5.0f)
        .masonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(150, 65));
        })
        .eventBlock(UIControlEventTouchUpInside, ^ (UIButton *sender) {
            @strongify(self);
            @strongify(view);
            [view dismissWithAnimated:!self.animatedDisable];
        });
    };
    
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 20, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"样式设置");
        
        {
            TLMenuSelectItem *item = [TLMenuSelectItem createWithTitle:@"父视图" menuItems:@[@"nil", @"self.view", @"keyWindow"]];
            item.selectedIndex = self.superType;
            self.addCell([TLMenuSelectItemCell class]).toSection(sectionType).withDataModel(item).eventAction(^ id(NSInteger type, NSNumber *index) {
                @strongify(self);
                self.superType = index.integerValue;
                return nil;
            });
        }
        
        {
            TLMenuSelectItem *item = [TLMenuSelectItem createWithTitle:@"风格" menuItems:@[@"半透明", @"全透明", @"毛玻璃"]];
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
    
    {
        NSInteger sectionType = 1;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 20, 0));
        self.addCell([TLMenuCenterItemCell class]).toSection(sectionType).withDataModel(@"显示").selectedAction(^ (NSString *title) {
            @strongify(self);
            TLMaskView *maskView = [[TLMaskView alloc] initWithStyle:self.maskStyle];
            addButton(maskView);
            maskView.disableTapEvent = self.tapDisable;
            __kindof UIView *view;
            if (self.superType == 1) {
                view = self.view;
            }
            else if (self.superType == 2) {
                view = [UIApplication sharedApplication].keyWindow;
            }
            [maskView showInView:view animated:!self.animatedDisable];
        });
    }
    
    [self reloadView];
}

@end
