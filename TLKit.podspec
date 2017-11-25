Pod::Spec.new do |s|
  s.name         = "TLKit"
  s.version      = "0.0.14"
  s.platform     = :ios, "8.0"
  s.summary      = "iOS开发基础组件库"
  s.description  = <<-DESC
    iOS开发基础组件库，主要包含以下内容：
    1、shortcut: 通用宏，通用快捷c方法
    2、Categories：通用类拓展
                   DESC
  
  s.author       = { "libokun" => "libokun@126.com" }
  s.homepage     = "https://github.com/tbl00c/TLKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source       = { :git => "https://github.com/tbl00c/TLKit.git", :tag => s.version }

  s.public_header_files = "TLKit/TLKit.h"
  s.source_files = "TLKit/TLKit.h"

  # 通用宏定义、快捷方法
  s.subspec 'TLShortcut' do |shortcut|
    shortcut.source_files = "TLKit/TLShortcut/*.{h,m}"
  end

  # 基础控件
  s.subspec 'TLFunctional' do |founc|
    founc.public_header_files = "TLKit/TLFunctional/TLFunctional.h"
    founc.source_files = "TLKit/TLFunctional/TLFunctional.h"

    # TLActionSheet
    founc.subspec 'TLActionSheet' do |ss|
      ss.source_files = "TLKit/TLFunctional/TLActionSheet/*.{h,m}"
    end

    # TLBadge
    #founc.subspec 'TLBadge' do |ss|
    #  ss.source_files = "TLKit/TLFunctional/TLBadge/*.{h,m}"
    #end

    # TLUIUtility
    founc.subspec 'TLUIUtility' do |ss|
      ss.source_files = "TLKit/TLFunctional/TLUIUtility/*.{h,m}"
      ss.dependency "TLKit/TLCategories/UIKit/UIAlertView"
      ss.dependency "TLKit/TLCategories/UIKit/UIWindow"
      ss.dependency "SVProgressHUD", "~> 2.2.2"
    end

  end

  
  # 通用分类
  s.subspec 'TLCategories' do |categories|
  	categories.public_header_files = "TLKit/TLCategories/TLCategories.h"
  	categories.source_files = "TLKit/TLCategories/TLCategories.h"

    # Foundation
    categories.subspec 'Foundation' do |foundation|
      foundation.public_header_files = "TLKit/TLCategories/Foundation/Foundation+TLCategories.h"
      foundation.source_files = "TLKit/TLCategories/Foundation/Foundation+TLCategories.h"

      # NSObject
      foundation.subspec 'NSObject' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSObject/**/*.{h,m}"
      end

      # NSArray
      foundation.subspec 'NSArray' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSArray/*.{h,m}"
      end

      # NSMutableArray
      foundation.subspec 'NSMutableArray' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSMutableArray/*.{h,m}"
      end

      # NSDictionary
      foundation.subspec 'NSDictionary' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSDictionary/*.{h,m}"
      end

      # NSMutableDictionary
      foundation.subspec 'NSMutableDictionary' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSMutableDictionary/*.{h,m}"
      end

      # NSData
      foundation.subspec 'NSData' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSData/*.{h,m}"
      end

      # NSDate
      foundation.subspec 'NSDate' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSDate/*.{h,m}"
      end

      # NSString
      foundation.subspec 'NSString' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSString/*.{h,m}"
        ss.dependency "TLKit/TLCategories/Foundation/NSData"
      end

      # NSTimer
      foundation.subspec 'NSTimer' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSTimer/*.{h,m}"
      end

      # NSBundle
      foundation.subspec 'NSBundle' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSBundle/*.{h,m}"
      end

      # NSURL
      foundation.subspec 'NSURL' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSURL/*.{h,m}"
      end

      # NSFileManager
      foundation.subspec 'NSFileManager' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSFileManager/*.{h,m}"
      end

      # NSNotificationCenter
      foundation.subspec 'NSNotificationCenter' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSNotificationCenter/*.{h,m}"
      end

      # NSDictionary
      foundation.subspec 'NSDictionary' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSDictionary/*.{h,m}"
      end
      
    end

    # UIKit
    categories.subspec 'UIKit' do |uikit|
      uikit.public_header_files = 'TLKit/TLCategories/UIKit/UIKit+TLCategories.h'
      uikit.source_files = 'TLKit/TLCategories/UIKit/UIKit+TLCategories.h'

      # UIView
      uikit.subspec 'UIView' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIView/*.{h,m}"
        ss.dependency "TLKit/TLShortcut"
        ss.dependency "TLKit/TLCategories/Foundation/NSObject"
      end

      # UIScrollView
      uikit.subspec 'UIScrollView' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIScrollView/*.{h,m}"
      end

      # UIButton
      uikit.subspec 'UIButton' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIButton/*.{h,m}"
        ss.dependency "TLKit/TLCategories/UIKit/UIImage"
      end
      
      # UIControl
      uikit.subspec 'UIControl' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIControl/*.{h,m}"
      end

      # UICollectionViewCell
      uikit.subspec 'UICollectionViewCell' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UICollectionViewCell/*.{h,m}"
      end

      # UIWindow
      uikit.subspec 'UIWindow' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIWindow/*.{h,m}"
      end

      # UIViewController
      uikit.subspec 'UIViewController' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIViewController/*.{h,m}"
        ss.dependency "TLKit/TLCategories/UIKit/UIView"
        ss.dependency "TLKit/TLCategories/UIKit/UINavigationController"
        ss.dependency "TLKit/TLCategories/UIKit/UIBarButtonItem"
      end

      # UINavigationController
      uikit.subspec 'UINavigationController' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UINavigationController/*.{h,m}"
      end

      # UIColor
      uikit.subspec 'UIColor' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIColor/*.{h,m}"
      end

      # UIImage
      uikit.subspec 'UIImage' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIImage/*.{h,m}"
      end

      # UITextField
      uikit.subspec 'UITextField' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UITextField/*.{h,m}"
      end

      # UITextView
      uikit.subspec 'UITextView' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UITextView/*.{h,m}"
      end

      # UIBarButtonItem
      uikit.subspec 'UIBarButtonItem' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIBarButtonItem/*.{h,m}"
      end

      # UINavigationItem
      uikit.subspec 'UINavigationItem' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UINavigationItem/*.{h,m}"
        ss.dependency "TLKit/TLCategories/UIKit/UIBarButtonItem"
      end

      # UINavigationBar
      uikit.subspec 'UINavigationBar' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UINavigationBar/*.{h,m}"
      end

      # UIAlertView
      uikit.subspec 'UIAlertView' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIAlertView/*.{h,m}"
      end
    end
    
  end
end
