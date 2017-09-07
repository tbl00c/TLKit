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
  
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "libokun" => "libokun@126.com" }
  s.homepage     = "https://github.com/tbl00c/TLKit"
  s.social_media_url   = "https://github.com/tbl00c"
  s.source       = { :git => "https://github.com/tbl00c/TLKit.git", :tag => s.version }

  s.subspec 'TLShortcut' do |ss|
    ss.source_files = "TLKit/TLShortcut/*.{h, m}"
  end
  
#  s.dependency 'MJRefresh', '~> 3.1.12'
end