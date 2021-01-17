//
//  TLActionSheetDemoViewController.m
//  TLKit_Example
//
//  Created by 李伯坤 on 2020/1/29.
//  Copyright © 2020 libokun. All rights reserved.
//

#import "TLActionSheetDemoViewController.h"
#import "TLMenuItemCell.h"
#import "TLMenuHeaderView.h"

@interface TLActionSheetDemoViewController ()

@end

@implementation TLActionSheetDemoViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:@"TLAlertView"];
    
    [self.view setBackgroundColor:RGBColor(240, 239, 245)];
    [self reloadTestMenu];
}

- (void)reloadTestMenu
{
    self.clear();
    
    TLActionSheetItemClickAction clickAction = ^(TLActionSheet *actionSheet, TLActionSheetItem *item, NSInteger index) {
        [TLAlertView showWithTitle:[NSString stringWithFormat:@"你点击了“%@”按钮", item.title] message:nil];
    };
    
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"普通样式");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"简化写法").selectedAction(^ (NSString *title) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"张三丰"];
            [actionSheet addItemWithTitle:@"个人中心" clickAction:clickAction];
            [actionSheet addItemWithTitle:@"交易记录及账单" clickAction:clickAction];
            [actionSheet addDestructiveItemWithTitle:@"退出账号" clickAction:clickAction];
            [actionSheet show];
        });
        
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"完整写法").selectedAction(^ (NSString *title) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"张三丰"];
            {
                TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithTitle:@"个人中心" clickAction:clickAction];
                [actionSheet addItem:item];
            }
            {
                TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithTitle:@"交易记录及账单" clickAction:clickAction];
                [actionSheet addItem:item];
            }
            {
                TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithType:TLActionSheetItemTypeDestructive title:@"退出账号" clickAction:clickAction];
                [actionSheet addItem:item];
            }
            [actionSheet show];
        });
        
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"带Message").selectedAction(^ (NSString *title) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"张三丰"];
            [actionSheet addItemWithTitle:@"百度" message:@"https://www.baidu.com" clickAction:clickAction];
            [actionSheet addItemWithTitle:@"阿里" message:@"https://www.taobao.com" clickAction:clickAction];
            [actionSheet addItemWithTitle:@"腾讯" message:@"https://www.qq.com" clickAction:clickAction];
            [actionSheet show];
        });
    }
    
    
    {
        NSInteger sectionType = 100;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"内容超长");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"超多按钮").selectedAction(^ (NSString *title) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:nil];
            for (NSInteger i = 0; i < 20; i++) {
                [actionSheet addItemWithTitle:[NSString stringWithFormat:@"按钮 %ld", i] clickAction:clickAction];
            }
            [actionSheet show];
        });
    }
    
    {
        NSInteger sectionType = 500;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"个性定制");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"定制弹窗样式").selectedAction(^ (NSString *title) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"Hello world"];
            [actionSheet setShadowColor:[[UIColor orangeColor] colorWithAlphaComponent:0.3]];
            [actionSheet setTitleColor:[UIColor blueColor]];
            [actionSheet setTitleFont:[UIFont boldSystemFontOfSize:32]];
            for (NSInteger i = 0; i < 5; i++) {
                [actionSheet addItemWithTitle:[NSString stringWithFormat:@"按钮 %ld", i] clickAction:clickAction];
            }
            [actionSheet show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"定制按钮样式").selectedAction(^ (NSString *title) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"Hello world"];
            [actionSheet addItemWithTitle:@"个人中心" clickAction:clickAction];
            
            TLActionSheetItem *item = [[TLActionSheetItem alloc] initWithTitle:@"帮助" clickAction:clickAction];
            [item setTitleFont:[UIFont boldSystemFontOfSize:28]];
            [item setTitleColor:[UIColor whiteColor]];
            [item setBackgroundColor:[UIColor orangeColor]];
            [item setSelectedBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:0.6]];
            [actionSheet addItem:item];
            
            [actionSheet show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"定制Header").selectedAction(^ (NSString *title) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 180)];
            [label setTextColor:[UIColor blackColor]];
            [label setFont:[UIFont systemFontOfSize:72]];
            [label setText:@"Hi"];
            [label setTextAlignment:NSTextAlignmentCenter];
            
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:label];
            for (NSInteger i = 0; i < 5; i++) {
                [actionSheet addItemWithTitle:[NSString stringWithFormat:@"按钮 %ld", i] clickAction:clickAction];
            }
            [actionSheet show];
        });
    }
    
    [self reloadView];
}

@end
