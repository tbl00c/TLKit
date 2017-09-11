Pod::Spec.new do |s|
  s.name         = "TLKit"
  s.version      = "0.0.1"
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

  # 通用宏定义、快捷方法
  s.subspec 'TLShortcut' do |shortcut|
    shortcut.source_files = "TLKit/TLShortcut/*.{h,m}"
  end

  
  # 通用分类
  s.subspec 'TLCategories' do |categories|

    # Foundation
    categories.subspec 'Foundation' do |foundation|
      # NSData
      foundation.subspec 'NSData' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSData/*/*.{h,m}"
      end

      # NSDate
      foundation.subspec 'NSDate' do |ss|
        ss.source_files = "TLKit/TLCategories/Foundation/NSDate/*.{h,m}"
      end

      
    end

    # UIKit
    categories.subspec 'UIKit' do |uikit|
      # UIView
      uikit.subspec 'UIView' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIView/*.{h,m}"
        ss.dependency "TLKit/TLShortcut"
        ss.dependency "TLKit/TLCategories/Foundation/NSData"
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
      end

      # UINavigationController
      uikit.subspec 'UINavigationController' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UINavigationController/**/*.{h,m}"
      end

      # UIColor
      uikit.subspec 'UIColor' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIColor/*.{h,m}"
      end

      # UIImage
      uikit.subspec 'UIImage' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UIImage/*.{h,m}"
      end

      # UINavigationBar
      uikit.subspec 'UINavigationBar' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UINavigationBar/*.{h,m}"
      end

      # UITextField
      uikit.subspec 'UITextField' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UITextField/*.{h,m}"
      end

      # UITextView
      uikit.subspec 'UITextView' do |ss|
        ss.source_files = "TLKit/TLCategories/UIKit/UITextView/*.{h,m}"
      end

    end
    
  end
end