Pod::Spec.new do |s|
  s.name         = "TLKit"
  s.version      = "2.0"
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

  classPath = 'TLKit/Classes/'
  
  s.public_header_files = classPath + "TLKit.h"
  s.source_files = classPath + "TLKit.h"

  # 通用宏定义、快捷方法
  s.subspec 'TLShortcut' do |shortcut|
    shortcut.source_files = classPath + "TLShortcut/*.{h,m}"
  end

  # 基础控件
  s.subspec 'TLComponents' do |founc|
    funcPath = classPath + 'TLComponents/'
    founc.public_header_files = funcPath + "TLComponents.h"
    founc.source_files = funcPath + "TLComponents.h"

	# TLMaskView
    founc.subspec 'TLMaskView' do |ss|
      ss.source_files = funcPath + "TLMaskView/*.{h,m}"
      ss.dependency 'ZZFLEX'
    end
    
    # TLCover
    founc.subspec 'TLCover' do |ss|
      ss.source_files = funcPath + "TLCover/**/*.{h,m}"
      ss.dependency 'TLKit/TLComponents/TLMaskView'
      ss.dependency 'TLKit/TLShortcut'
    end

    # TLActionSheet
    founc.subspec 'TLActionSheet' do |ss|
      ss.source_files = funcPath + "TLActionSheet/*.{h,m}"
    end
    
    # TLAlertView
    founc.subspec 'TLAlertView' do |ss|
      ss.source_files = funcPath + "TLAlertView/*.{h,m}"
    end

    # TLBadge
    #founc.subspec 'TLBadge' do |ss|
    #  ss.source_files = funcPath + "TLBadge/*.{h,m}"
    #end

    # TLToast
    founc.subspec 'TLToast' do |ss|
      ss.source_files = funcPath + "TLToast/*.{h,m}"
      ss.dependency "SVProgressHUD", "~> 2.2.5"
    end
    
    founc.subspec 'TLTheme' do |ss|
      ss.source_files = funcPath + "TLTheme/*.{h,m}"
    end

    # TLColor
    founc.subspec 'TLColor' do |ss|
      ss.source_files = funcPath + "TLColor/*.{h,m}"
      ss.dependency "TLKit/TLCategories/UIKit/UIColor"
      ss.dependency "TLKit/TLShortcut"
      ss.dependency "TLKit/TLComponents/TLTheme"
      ss.resource = funcPath + 'TLColor/TLColorTable.txt'
    end

    # TLPictureCarouselView
    founc.subspec 'TLPictureCarouselView' do |ss|
      ss.source_files = funcPath + "TLPictureCarouselView/*.{h,m}"
      ss.dependency "TLKit/TLCategories/UIKit/UIScrollView"
    end

    # TLLocalPushManager
    founc.subspec 'TLLocalPushManager' do |ss|
      ss.source_files = funcPath + "TLLocalPushManager/*.{h,m}"
    end

    # TLStatusBarAlert
    founc.subspec 'TLStatusBarAlert' do |ss|
      ss.source_files = funcPath + "TLStatusBarAlert/**/*.{h,m}"
    end

    # GKCover
    founc.subspec 'GKCover' do |ss|
      ss.source_files = funcPath + "GKCover/**/*.{h,m}"
    end

    # RSA
    founc.subspec 'RSA' do |ss|
      ss.source_files = funcPath + "RSA/*.{h,m}"
    end

    # TLAlertnateIconManager
    founc.subspec 'TLAlertnateIconManager' do |ss|
      ss.source_files = funcPath + "TLAlertnateIconManager/*.{h,m}"
    end
    
    # TLAlertnateIconManager
    founc.subspec 'TLAppUtility' do |ss|
      ss.source_files = funcPath + "TLAppUtility/*.{h,m}"
    end
    
    # TLAlwaysActivity
    founc.subspec 'TLAlwaysActivity' do |ss|
      ss.source_files = funcPath + "TLAlwaysActivity/*.{h,m}"
      ss.resource = funcPath + 'TLAlwaysActivity/*.m4a'
    end
  end

  
  # 通用分类
  s.subspec 'TLCategories' do |categories|
    catePath = classPath + 'TLCategories/'
    foundationPath = catePath + "Foundation/"
    uikitPath = catePath + "UIKit/"
    caPath = catePath + "CoreAnimation/"
    
    categories.public_header_files = catePath + "TLCategories.h"
    categories.source_files = catePath + "TLCategories.h"
    
    # Foundation
    categories.subspec 'Foundation' do |foundation|
      foundation.public_header_files = foundationPath + "Foundation+TLCategories.h"
      foundation.source_files = foundationPath + "Foundation+TLCategories.h"

      # NSObject
      foundation.subspec 'NSObject' do |ss|
        ss.source_files = foundationPath + "NSObject/**/*.{h,m}"
      end

      # NSArray
      foundation.subspec 'NSArray' do |ss|
        ss.source_files = foundationPath + "NSArray/*.{h,m}"
      end

      # NSMutableArray
      foundation.subspec 'NSMutableArray' do |ss|
        ss.source_files = foundationPath + "NSMutableArray/*.{h,m}"
      end

      # NSDictionary
      foundation.subspec 'NSDictionary' do |ss|
        ss.source_files = foundationPath + "NSDictionary/*.{h,m}"
      end

      # NSMutableDictionary
      foundation.subspec 'NSMutableDictionary' do |ss|
        ss.source_files = foundationPath + "NSMutableDictionary/*.{h,m}"
      end

      # NSData
      foundation.subspec 'NSData' do |ss|
        ss.source_files = foundationPath + "NSData/*.{h,m}"
      end

      # NSDate
      foundation.subspec 'NSDate' do |ss|
        ss.source_files = foundationPath + "NSDate/*.{h,m}"
      end

      # NSString
      foundation.subspec 'NSString' do |ss|
        ss.source_files = foundationPath + "NSString/*.{h,m}"
        ss.dependency "TLKit/TLCategories/Foundation/NSData"
      end

      # NSTimer
      foundation.subspec 'NSTimer' do |ss|
        ss.source_files = foundationPath + "NSTimer/*.{h,m}"
      end

      # NSBundle
      foundation.subspec 'NSBundle' do |ss|
        ss.source_files = foundationPath + "NSBundle/*.{h,m}"
      end

      # NSURL
      foundation.subspec 'NSURL' do |ss|
        ss.source_files = foundationPath + "NSURL/*.{h,m}"
      end

      # NSFileManager
      foundation.subspec 'NSFileManager' do |ss|
        ss.source_files = foundationPath + "NSFileManager/*.{h,m}"
      end

      # NSNotificationCenter
      foundation.subspec 'NSNotificationCenter' do |ss|
        ss.source_files = foundationPath + "NSNotificationCenter/*.{h,m}"
      end

      # NSDictionary
      foundation.subspec 'NSDictionary' do |ss|
        ss.source_files = foundationPath + "NSDictionary/*.{h,m}"
      end
      
    end

    # UIKit
    categories.subspec 'UIKit' do |uikit|
      uikit.public_header_files = uikitPath + 'UIKit+TLCategories.h'
      uikit.source_files = uikitPath + 'UIKit+TLCategories.h'

      # UIView
      uikit.subspec 'UIView' do |ss|
        ss.source_files = uikitPath + "UIView/*.{h,m}"
        ss.dependency "TLKit/TLShortcut"
        ss.dependency "TLKit/TLCategories/Foundation/NSObject"
      end

      # UIScrollView
      uikit.subspec 'UIScrollView' do |ss|
        ss.source_files = uikitPath + "UIScrollView/*.{h,m}"
      end

      # UIButton
      uikit.subspec 'UIButton' do |ss|
        ss.source_files = uikitPath + "UIButton/*.{h,m}"
#        ss.dependency uikitPath + "UIImage"
      end
      
      # UIControl
      uikit.subspec 'UIControl' do |ss|
        ss.source_files = uikitPath + "UIControl/*.{h,m}"
      end

      # UICollectionViewCell
      uikit.subspec 'UICollectionViewCell' do |ss|
        ss.source_files = uikitPath + "UICollectionViewCell/*.{h,m}"
      end

      # UIWindow
      uikit.subspec 'UIWindow' do |ss|
        ss.source_files = uikitPath + "UIWindow/*.{h,m}"
      end

      # UIViewController
      uikit.subspec 'UIViewController' do |ss|
        ss.source_files = uikitPath + "UIViewController/*.{h,m}"
        ss.dependency "TLKit/TLCategories/UIKit/UIView"
        ss.dependency "TLKit/TLCategories/UIKit/UINavigationController"
        ss.dependency "TLKit/TLCategories/UIKit/UIBarButtonItem"
      end

      # UINavigationController
      uikit.subspec 'UINavigationController' do |ss|
        ss.source_files = uikitPath + "UINavigationController/*.{h,m}"
      end

      # UINavigationController
      uikit.subspec 'UITabBarController' do |ss|
        ss.source_files = uikitPath + "UITabBarController/*.{h,m}"
      end

      # UIColor
      uikit.subspec 'UIColor' do |ss|
        ss.source_files = uikitPath + "UIColor/*.{h,m}"
      end

      # UIImage
      uikit.subspec 'UIImage' do |ss|
        ss.source_files = uikitPath + "UIImage/*.{h,m}"
      end

      # UITextField
      uikit.subspec 'UITextField' do |ss|
        ss.source_files = uikitPath + "UITextField/*.{h,m}"
      end

      # UITextView
      uikit.subspec 'UITextView' do |ss|
        ss.source_files = uikitPath + "UITextView/*.{h,m}"
      end

      # UIBarButtonItem
      uikit.subspec 'UIBarButtonItem' do |ss|
        ss.source_files = uikitPath + "UIBarButtonItem/*.{h,m}"
      end

      # UINavigationItem
      uikit.subspec 'UINavigationItem' do |ss|
        ss.source_files = uikitPath + "UINavigationItem/*.{h,m}"
        ss.dependency "TLKit/TLCategories/UIKit/UIBarButtonItem"
      end

      # UINavigationBar
      uikit.subspec 'UINavigationBar' do |ss|
        ss.source_files = uikitPath + "UINavigationBar/*.{h,m}"
      end

      # UIAlertView
      uikit.subspec 'UIAlertView' do |ss|
        ss.source_files = uikitPath + "UIAlertView/*.{h,m}"
      end
    end
  end
end
