//
//  TLAlertViewDemoViewController.m
//  TLKit_Example
//
//  Created by 李伯坤 on 2020/1/29.
//  Copyright © 2020 libokun. All rights reserved.
//

#import "TLAlertViewDemoViewController.h"
#import "TLMenuItemCell.h"
#import "TLMenuHeaderView.h"

@interface TLAlertViewDemoViewController ()

@end

@implementation TLAlertViewDemoViewController

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
    
    TLAlertViewItemClickAction clickAction = ^(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index) {
        [TLAlertView showWithTitle:[NSString stringWithFormat:@"你点击了“%@”按钮", item.title] message:nil];
    };
    
    {
        NSInteger sectionType = 0;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"警告类(简化写法)");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"仅标题").selectedAction(^ (NSString *title) {
            [TLAlertView showWithTitle:@"这是一个警告框" message:nil];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"仅正文").selectedAction(^ (NSString *title) {
            [TLAlertView showWithTitle:nil message:@"可以在这儿配置正文，行数不限制，超高自动滚动"];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"标题+正文").selectedAction(^ (NSString *title) {
            [TLAlertView showWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，超高自动滚动"];
        });
    }
    
    {
        NSInteger sectionType = 100;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"内容超长");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"超长标题").selectedAction(^ (NSString *title) {
            [TLAlertView showWithTitle:[self getLongMessage] message:nil];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"标题+超长正文").selectedAction(^ (NSString *title) {
            [TLAlertView showWithTitle:@"笑话国日记" message:[self getLongMessage]];
        });
    }
    
    {
        NSInteger sectionType = 200;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"确认类（简化按钮添加方法）");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"双按钮").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，支持自动滚动"];
            [alertView addCancelItemTitle:@"取消" clickAction:clickAction];
            [alertView addItemWithTitle:@"确定" clickAction:clickAction];
            [alertView show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"三按钮").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，支持自动滚动"];
            [alertView addCancelItemTitle:@"稍候决定" clickAction:clickAction];
            [alertView addItemWithTitle:@"退出" clickAction:clickAction];
            [alertView addDestructiveItemWithTitle:@"确认并继续" clickAction:clickAction];
            [alertView show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"超多按钮").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，支持自动滚动"];
            for (NSInteger i = 0; i < 10; i++) {
                [alertView addItemWithTitle:[NSString stringWithFormat:@"按钮%ld", i] clickAction:clickAction];
            }
            [alertView show];
        });
    }
    
    {
        NSInteger sectionType = 300;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"倒计时");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"5秒倒计时(期间不可点击)").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"请仔细阅读《用户协议》" message:[self getLongMessage]];
            [alertView addCancelItemTitle:@"拒绝" clickAction:nil];
            TLAlertViewItem *item = [[TLAlertViewItem alloc] initWithTitle:@"同意" clickAction:clickAction countdownTime:@(5) countdownAction:^(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index) {
                [item setDisable:NO];
            }];
            [item setDisable:YES];
            [alertView addItem:item];
            [alertView show];
        });
    }
    
    {
        TLAlertViewItemClickAction clickActionWithTextField = ^(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index) {
            [TLAlertView showWithTitle:@"你输入的内容" message:alertView.textField.text];
        };
        
        NSInteger sectionType = 400;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"带输入框");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"标题+输入框").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"请输入内容" message:nil];
            [alertView addCancelItemTitle:@"取消" clickAction:nil];
            [alertView addItemWithTitle:@"确定" clickAction:clickActionWithTextField];
            [alertView addTextFieldWithConfigAction:^(TLAlertView *alertView, UITextField *textField) {
                [textField setPlaceholder:@"请输入内容"];
            }];
            [alertView show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"标题+正文+输入框").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，支持自动滚动"];
            [alertView addCancelItemTitle:@"取消" clickAction:nil];
            [alertView addItemWithTitle:@"确定" clickAction:clickActionWithTextField];
            [alertView addTextFieldWithConfigAction:^(TLAlertView *alertView, UITextField *textField) {
                [textField setPlaceholder:@"请输入内容"];
            }];
            [alertView show];
        });
    }
    
    {
        NSInteger sectionType = 500;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 10, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"个性定制");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"定制弹窗样式").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"警告" message:@"Hello world!"];
            [alertView setTitleFont:[UIFont boldSystemFontOfSize:42]];
            [alertView setTitleColor:[UIColor redColor]];
            [alertView setMessageFont:[UIFont boldSystemFontOfSize:32]];
            [alertView setMessageColor:[UIColor orangeColor]];
            [alertView addItemWithTitle:@"确定" clickAction:nil];
            [alertView show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"定制弹窗内容").selectedAction(^ (NSString *title) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 180)];
            [label setTextColor:[UIColor blackColor]];
            [label setFont:[UIFont systemFontOfSize:72]];
            [label setText:@"Hi"];
            [label setTextAlignment:NSTextAlignmentCenter];
            
            TLAlertView *alertView = [[TLAlertView alloc] initWithCustomView:label];
            [alertView addItemWithTitle:@"确定" clickAction:nil];
            [alertView show];
        });
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"定制按钮样式").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，支持自动滚动"];
            
            TLAlertViewItem *cancelItem = [[TLAlertViewItem alloc] initWithTitle:@"拒绝" clickAction:nil];
            [cancelItem setTitleFont:[UIFont boldSystemFontOfSize:26]];
            [cancelItem setTitleColor:[UIColor orangeColor]];
            [alertView addItem:cancelItem];
            
            TLAlertViewItem *okItem = [[TLAlertViewItem alloc] initWithTitle:@"同意" clickAction:clickAction];
            [okItem setTitleFont:[UIFont boldSystemFontOfSize:26]];
            [okItem setTitleColor:[UIColor brownColor]];
            [alertView addItem:okItem];
            
            [alertView show];
        });
    }
    
    {
        NSInteger sectionType = 600;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(0, 0, 50, 0));
        self.setHeader([TLMenuHeaderView class]).toSection(sectionType).withDataModel(@"热更新");
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"修改内容及样式").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，支持自动滚动"];
            {
                TLAlertViewItem *item = [[TLAlertViewItem alloc] initWithTitle:@"修改标题和正文" clickAction:^(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index) {
                    [alertView setTitle:@"这是修改后的标题"];
                    [alertView setMessage:@"这是修改后的正文"];
                }];
                [item setDisableDismissAfterClick:YES];
                [alertView addItem:item];
            }
            {
                TLAlertViewItem *item = [[TLAlertViewItem alloc] initWithTitle:@"修改字体和颜色" clickAction:^(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index) {
                    [alertView setTitleFont:[UIFont boldSystemFontOfSize:32]];
                    [alertView setTitleColor:[UIColor orangeColor]];
                    [alertView setMessageFont:[UIFont boldSystemFontOfSize:28]];
                    [alertView setMessageColor:[UIColor blueColor]];
                }];
                [item setDisableDismissAfterClick:YES];
                [alertView addItem:item];
            }
            [alertView addCancelItemTitle:@"关闭" clickAction:nil];
            [alertView show];
        });
        
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"增加按钮").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，支持自动滚动"];
            
            TLAlertViewItem *item = [[TLAlertViewItem alloc] initWithTitle:@"新增按钮" clickAction:^(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index) {
                [alertView addItemWithTitle:@"关闭" clickAction:nil];
            }];
            [item setDisableDismissAfterClick:YES];
            [alertView addItem:item];
            
            [alertView show];
        });
        
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"修改按钮标题、样式、倒计时").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，支持自动滚动"];
            TLAlertViewItem *item = [[TLAlertViewItem alloc] initWithTitle:@"开始关闭倒计时" clickAction:^(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index) {
                [item setTitle:@"关闭"];
                [item setTitleFont:[UIFont boldSystemFontOfSize:22]];
                [item setTitleColor:[UIColor redColor]];
                [item setDisableDismissAfterClick:NO];
                [item startCountDown:@(5) countdownAction:^(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index) {
                    [alertView dismiss];
                }];
            }];
            [item setDisableDismissAfterClick:YES];
            [alertView addItem:item];
            
            [alertView show];
        });
        
        self.addCell([TLMenuItemCell class]).toSection(sectionType).withDataModel(@"修改自定义样式").selectedAction(^ (NSString *title) {
            TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:@"这是一个警告框" message:@"可以在这儿配置正文，行数不限制，支持自动滚动"];
            TLAlertViewItem *item = [[TLAlertViewItem alloc] initWithTitle:@"展示自定义样式" clickAction:^(TLAlertView *alertView, TLAlertViewItem *item, NSInteger index) {
                if (alertView.customView) {
                    [(UILabel *)alertView.customView setText:@"Hello"];
                    [item setTitle:@"关闭"];
                    [item setDisableDismissAfterClick:NO];
                }
                else {
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 180)];
                    [label setTextColor:[UIColor blackColor]];
                    [label setFont:[UIFont systemFontOfSize:72]];
                    [label setText:@"Hi"];
                    [label setTextAlignment:NSTextAlignmentCenter];
                    [alertView setCustomView:label];
                    [item setTitle:@"修改自定义样式"];
                }
            }];
            [item setDisableDismissAfterClick:YES];
            [alertView addItem:item];
            
            [alertView show];
        });
    }
    
    [self reloadView];
}

- (NSString *)getLongMessage
{
    NSString *message = @"从前有个笑话国，盛产笑话和笑话人，每天太阳从西边认真的升起，带着笑脸，发出光芒，照到笑话人的脸上，笑话人起床的时间是基本一致的，起床先对着太阳哈哈哈三声大笑，然后照着镜子，笑上好一会，才规规矩矩的开始穿衣服，每个人都穿的整整齐齐，这样子，在一天的笑话时光里，，衣服也会被整的七零八落。\n关于笑话国，有一个最流行的说法，曾经有一位让人尊崇的笑话家，年轻的时候就很有天赋，发觉笑话的角度十分刁钻，所以他一开始和周边的人讲一个笑话，周遭的人先是没有察觉，有些疑惑，装作似懂非懂，如果天赋有一些，走在回家的路上一琢磨，就哈哈大笑走回家，给家里人复述一遍。但倘若天赋一般，那就要好好咬文嚼字，苦苦思索，有的人茶不思，饭不香般思考，也不一定会有结果。所以笑话家越来越受人尊崇，众人见到笑话家，一定要先大声笑出来，待他走远，再慢慢收起笑声。当然笑声不能收太久，如果许久不笑一笑，让其他笑话人看到，肯定就会平添些许嫌弃。\n在笑话国，是有一些不爱笑的人，这种人生下来不爱笑，就是天性，长辈往往很着急，给孩子讲笑话，看笑话，亲自上阵示范各种仿佛好笑的示例，甚至打孩子，要他笑，但是孩子不过就是不爱笑，往往越长大越让家长无奈，这样这个人就慢慢让人瞧不起，也随着时间愈发瞧不起，众人大笑同行，见到这种人，尴尬而笑又大笑离去，连父母最后也是嫌弃，你想，夫妻二人哈哈大笑旁边这人却不配合，这笑声都不爽朗。\n这种人往往寿命不会长久，肯定是不会长久，周围人因为笑所以长命百岁，他们不笑，若还是能长命百岁，这不是明摆着让笑话国人难堪，所以倘若这人真不爱笑，笑话国会遵照笑话国大的不行最最大宪法第零条规定，成年之后如果还不悔改，就会被判流放或者终生监禁。\n对于这些人来说，流放还好，除了笑话国，其它地方倒没有那么爱笑。但是监禁就不同了，在监狱里面，狱警会成群结队站在你面前哈哈大笑，这仅仅是第一步，许多人受感染也情不自禁大笑起来。倘若自己实在找不到笑的缘由，憋屈着，狱警就会散去，一个一个来给你讲笑话，从笑话国伊始的远古笑话到昨天才听闻到的最新笑话，不停地讲，但这往往没有什么效果，往往犯人不会笑，也不知为何会笑，反倒是狱警笑个不停。最后，这些犯人会被流放到别处，也有直接死在狱中，这是不会被人同情的，家人来的时候也是一路笑声。\n每晚七点，笑话国就会播放笑话集锦，这可是笑话国一天最隆重的事情，所有的媒体都会一同播放笑话集锦，头二十分钟是一个铺垫，一个笑话比一个笑话愈发能让人发笑，所有人都在大笑着，并等待最精彩的十分钟，将今天的笑意尽情释放，晚上就是星点笑意，不会再大笑，知道都一个个睡去，笑话国集体进入梦乡，梦到的都是过往的笑话，夜里也咯咯的笑。\n但是最近，有一个传言在笑话国里流传，那就是那个在笑话国历史上受人尊崇的笑话家，在临终之前，写过一本笑话国日记，而日记里面，有关于笑话国里面的许多秘密，这可一下子让笑话国的人兴奋了起来，毕竟笑话国的人儿许久只会笑，并不会惊奇，更谈不上兴奋，但是这次不一样，兴奋如病毒一样扩散，每个人眼里都有异样的东西在闪动，过去聚在一起总是交流笑话段子，现在却是几个人哈哈一笑，立马收下笑脸，相互打听日记的内容，往往也没有什么收获，再哈哈一笑，相互散去。\n这种事官方当然是要辟谣的，新闻里两个主播先是哈哈哈哈哈大笑起来，笑得正起劲，一个人说最近谣传有笑话家的日记，这是个谣言，哈哈哈哈又继续笑下去，许久才继续播下一个新闻。\n国人见到，也就放心了，人们再三三两两凑到一起的时候，也不再议论什么，继续爽朗的笑着。\n但是平时不爱笑的人，却并没有就此罢休，这里面要是真有些秘密，对于他们可是好事，道理很简单，对于笑话国不好的事情对于他们就是好事。所以即使官方有辟谣，笑话生活在继续，但是不爱笑的人仍然乐此不疲的把这个消息传到笑话国的方方面面，倘若是以往，这些东西肯定都会被笑声所淹没，但这一次却不同，人们不知为何认真了起来，所有的人再相聚的时候，倘若是生人，\n仍要按过往的规矩，哈哈哈大笑几声，但是也往往无法继续下去。若是熟人相见，定是没有什么欢声笑语。\n这次的煽风点火不知为何，出奇的成功，幕后策划者是谁，大家都很清楚，必然是不爱笑的人，但是知道又如何，许多人惊奇的发现自己也变成如此模样，这可真让人感到害怕！\n渐渐的，笑话国沉寂了下来，越来越少的人脸上有笑容，直到有一天，只有国王仍然天天大笑，其他人已经无动于衷。\n最危险的事情还是发生了，有一天，所有人聚在了王宫外，每一个脸上都看不到一丝笑容，太阳看见之后也躲了起来，国王急匆匆出来，看着大家，先是按照规矩大笑起来，却突然被众人打断：“别笑啦，我们要看笑话家的日记，快给我们看！”国王脸上也第一次有了不悦，但又无可奈何，这是他此生第一次遇到这种情况，以往他一出现，所有人的笑声会格外响亮。\n没过一会，屏幕上出现了日记的最后一页，上面用古老的笑话体写着歪歪扭扭的字，底下是工整的翻译：我们是笑话，这是个笑话，这真是个笑话！\n人群没有反应，直到一个人突然大笑：“这是个笑话，哈哈哈。”所有的人立马被这笑声感染，也被这笑话所感染，“对，这是个笑话”“多么好笑”“太好笑了”“哈哈哈哈哈哈哈”。\n笑声汇聚在一起，人群变成了欢乐的海洋，每个人都尽情的笑着，笑着。\n后记：\n想写一本戏，名曰最悲的悲剧，里面充满了无耻的笑声－－老舍";
    return message;
}

@end
