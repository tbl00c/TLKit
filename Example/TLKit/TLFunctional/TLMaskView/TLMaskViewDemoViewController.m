//
//  TLMaskViewDemoViewController.m
//  TLKit_Example
//
//  Created by libokun on 2021/1/2.
//  Copyright © 2021 libokun. All rights reserved.
//

#import "TLMaskViewDemoViewController.h"
#import "TLMenuItemCell.h"
#import "TLMenuHeaderView.h"
#import <TLKit/TLMaskView.h>

@interface TLMaskViewDemoViewController ()

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
    self.clear();
    
    void (^addButton)(TLMaskView *view) = ^(TLMaskView *view) {
        view.addButton(1).backgroundColor([UIColor redColor]).title(@"关闭")
        .titleFont([UIFont boldSystemFontOfSize:22]).titleColor([UIColor whiteColor])
        .cornerRadius(5.0f)
        .masonry(^(__kindof UIView *sender, MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(150, 65));
        })
        .eventBlock(UIControlEventTouchUpInside, ^ (UIButton *sender) {
            [view dismiss];
        });
    };
    
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"半透明样式");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"显示").selectedAction(^ (NSString *title) {
            TLMaskView *maskView = [[TLMaskView alloc] init];
            addButton(maskView);
            [maskView show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"在当前视图显示").selectedAction(^ (NSString *title) {
            TLMaskView *maskView = [[TLMaskView alloc] init];
            addButton(maskView);
            [maskView showInView:self.view];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"在当前keyWindow显示").selectedAction(^ (NSString *title) {
            TLMaskView *maskView = [[TLMaskView alloc] init];
            addButton(maskView);
            [maskView showInView:[UIApplication sharedApplication].keyWindow];
        });
    }
    
    {
        NSInteger sectionType = 1;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"全透明样式");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"显示").selectedAction(^ (NSString *title) {
            TLMaskView *maskView = [[TLMaskView alloc] initWithStyle:TLMaskViewStyleTransparent];
            addButton(maskView);
            [maskView show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"在当前视图显示").selectedAction(^ (NSString *title) {
            TLMaskView *maskView = [[TLMaskView alloc] initWithStyle:TLMaskViewStyleTransparent];
            addButton(maskView);
            [maskView showInView:self.view];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"在当前keyWindow显示").selectedAction(^ (NSString *title) {
            TLMaskView *maskView = [[TLMaskView alloc] initWithStyle:TLMaskViewStyleTransparent];
            addButton(maskView);
            [maskView showInView:[UIApplication sharedApplication].keyWindow];
        });
    }
    
    {
        NSInteger sectionType = 2;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"高斯模糊样式");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"显示").selectedAction(^ (NSString *title) {
            TLMaskView *maskView = [[TLMaskView alloc] initWithStyle:TLMaskViewStyleBlur];
            addButton(maskView);
            [maskView show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"在当前视图显示").selectedAction(^ (NSString *title) {
            TLMaskView *maskView = [[TLMaskView alloc] initWithStyle:TLMaskViewStyleBlur];
            addButton(maskView);
            [maskView showInView:self.view];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"在当前keyWindow显示").selectedAction(^ (NSString *title) {
            TLMaskView *maskView = [[TLMaskView alloc] initWithStyle:TLMaskViewStyleBlur];
            addButton(maskView);
            [maskView showInView:[UIApplication sharedApplication].keyWindow];
        });
    }
    [self reloadView];
}

@end
