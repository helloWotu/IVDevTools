#
#  Be sure to run `pod spec lint IVDevTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name          = "IVDevTools"
  spec.version       = "1.0.1"
  spec.summary       = "IVDevTools是Swift编写的开发调试工具，包含日志模块、环境变量两大模块。"
  spec.homepage      = "https://github.com/GWTimes/IVDevTools"
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.author        = { "JonorZhang" => "zyx1507@163.com" }

  spec.platform      = :ios, "9.0"
  spec.source        = { :git => "https://github.com/GWTimes/IVDevTools.git", :tag => "#{spec.version}" }
  spec.source_files  = "IVDevTools/**/*.{h,m,swift}"
  spec.swift_version = '5.0'
  spec.requires_arc  = true
end
