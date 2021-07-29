#
#  Be sure to run `pod spec lint IVDevTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name          = "IVDevTools"
  spec.version       = "1.0.2"
  spec.summary       = "A lightweight development and debugging tools"
  spec.description   = "IVDevTools is a lightweight development and debugging tools with a user interface, written in Swift, and consists of two modules, the logging and Environment Variable."
  spec.homepage      = "https://github.com/GWTimes/IVDevTools"
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.author        = { "JonorZhang" => "zyx1507@163.com" }

  spec.platform      = :ios, "9.0"
  spec.swift_version = '5.0'
  spec.requires_arc  = true
  spec.source        = { :git => "https://github.com/GWTimes/IVDevTools.git", :tag => "#{spec.version}" }
  spec.source_files  = "IVDevTools/**/*.{h,m,swift}"
  spec.resource_bundle = { "Resource" => "Resource/*.{xcassets,storyboard}" }
end
