# IVDevTools

[![CI Status](https://img.shields.io/travis/jonorzhang/IVDevTools.svg?style=flat)](https://travis-ci.org/jonorzhang/IVDevTools)
[![Version](https://img.shields.io/cocoapods/v/IVDevTools.svg?style=flat)](https://cocoapods.org/pods/IVDevTools)
[![License](https://img.shields.io/cocoapods/l/IVDevTools.svg?style=flat)](https://cocoapods.org/pods/IVDevTools)
[![Platform](https://img.shields.io/cocoapods/p/IVDevTools.svg?style=flat)](https://cocoapods.org/pods/IVDevTools)

**IVDevTools** is a lightweight development and debugging tool with a user interface, written in Swift, and consists of two modules, the logging and Environment Variable.

## Requirements

## Installation

IVDevTools is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'IVDevTools'
```

## Usage

```swift
// step 1: import module
import IVDevTools

// step 2: add `IVDevToolsAssistant` on the window
let window = (UIApplication.shared.delegate as! AppDelegate).window
window?.addSubview(IVDevToolsAssistant.shared)

// step 3: click floating button of `IVDevToolsAssistant` on the screen and use it
```


## Author

jonorzhang, zyx1507@163.com

## License

IVDevTools is available under the MIT license. See the LICENSE file for more info.
