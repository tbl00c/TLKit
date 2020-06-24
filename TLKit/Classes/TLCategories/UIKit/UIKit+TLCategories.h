//
//  UIKit+TLCategories.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#ifndef UIKit_TLCategories_h
#define UIKit_TLCategories_h

//MARK: UIView
#import "UIView+TLFrame.h"                        // UIView 的一些关于坐标、大小的快捷属性
#import "UIView+TLExtensions.h"                   // UIView 关于subView、所在VC、当前状态的拓展
#import "UIView+TLScreenshot.h"                   // UIView 截屏
#import "UIView+TLTipView.h"                      // UIView 错误提示View（无网、无数据等）

//MARK: UIControl
#import "UIControl+TLActionBlocks.h"              // UIColor 事件响应block

//MARK: UIButton
#import "UIButton+TLExtensions.h"                 // UIButton 设置背景色、图文混排

//MAKR: UIImage
#import "UIImage+TLColor.h"                       // UIImage 根据颜色初始化
#import "UIImage+TLSize.h"                        // UIImage 图片缩放
#import "UIImage+TLDarkMode.h"                    // UIColor DarkMode

//MARK: UIColor
#import "UIColor+TLExtensions.h"                  // UIColor 根据16进制字符串创建颜色
#import "UIColor+TLGradient.h"                    // UIColor 渐变色
#import "UIColor+TLDarkMode.h"                    // UIColor DarkMode

//MARK: UIScrollView
#import "UIScrollView+TLExtensions.h"             // UIScrollView contentOffset、contentSize、滚动方法拓展等
#import "UIScrollView+TLPages.h"                  // UIScrollView 分页拓展
#import "UIScrollView+TLiOS11Fixed.h"             // UIScrollView iOS11

//MARK: UITextField
#import "UITextField+TLLengthLimit.h"             // UITextField 长度限制
#import "UITextField+TLSelect.h"                  // UITextField 文字选择

//MARK: UITextView
#import "UITextView+TLPlaceholder.h"              // UITextView placeHolder
#import "UITextView+TLLengthLimit.h"              // UITextView 长度限制
#import "UITextView+TLSelect.h"                   // UITextView 文字选择

//MARK: UICollectionViewCell
#import "UICollectionViewCell+TLExtensions.h"     // UICollectionViewCell 高亮色设置

//MARK: UIBarButtonItem
#import "UIBarButtonItem+TLAction.h"              // UIBarButtonItem blcok

//MARK: UINavigationBar
#import "UINavigationBar+TLExtensions.h"          // UINavigationBar 背景色，透明度等

//MARK: UINavigationController
#import "UINavigationController+TLExtensions.h"   // UINavigationController 获取rootVC，查找VC，pop到指定VC等

//MARK: UITabBarController+TLPush
#import "UITabBarController+TLPush.h"           // UITabBarController 当前VC Push

//MARK: UIViewController
#import "UIViewController+TLNavBar.h"             // UIViewController navBar按钮
#import "UIViewController+TLTipView.h"            // UIViewController 错误提示View（依赖UIView+TLTipView）
#import "UIViewController+TLTabBarHidden.h"

//MARK: UIWindow
#import "UIWindow+TLExtensions.h"                 // UIWindow 获取当前VC

//MARK: UIAlertView
#import "UIAlertView+TLActionBlocks.h"            // UIAlertView 事件响应block

#endif /* UIKit_TLCategories_h */
