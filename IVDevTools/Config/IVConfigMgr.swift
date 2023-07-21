//
//  IVConfigMgr.swift
//  IVLogger
//
//  Created by Zhang on 2019/9/8.
//  Copyright © 2019 JonorZhang. All rights reserved.
//

import UIKit

/// 配置
public struct Config: Codable {
    /// 名称：配置的名称，不可重复
    public var name: String
    /// 键：表明配置的是什么参数，可同时存在多个不同名称的键
    public var key: String
    /// 值
    public var value: String
    /// 开关
    public var enable: Bool
}

@objc public class IVConfigMgr: NSObject {
    
    static let kAllConfigKeys = "IVConfigKeys"
        
    static var allConfigs: [Config] = {
        var allCfgs: [Config] = []
        
        if let data = UserDefaults.standard.data(forKey: kAllConfigKeys),
            let cfgs = try? JSONDecoder().decode([Config].self, from: data), !cfgs.isEmpty {
            allCfgs = cfgs
        }
        
        let defaultCfgs = [
//            Config(name: "SECRECT_ID", key: "IOT_TEST_SECRECT_ID", value: "", enable: false),
//            Config(name: "SECRECT_KEY", key: "IOT_TEST_SECRECT_KEY", value: "", enable: false),
//            Config(name: "用户名", key: "IOT_TEST_USER_NAME", value: "", enable: false),
//            Config(name: "回放策略", key: "IOT_PLAYBACK_STRATEGY", value: "0", enable: false),
//            Config(name: "音视频调试", key: "IOT_AV_DEBUG", value: "true", enable: false),
//            Config(name: "P2P测试服", key: "IOT_HOST_P2P", value: "TEST", enable: false),
//            Config(name: "WEB测试服", key: "IOT_HOST_WEB", value: "TEST", enable: false),
//            Config(name: "云服务ID", key: "IOT_VAS_SERVICE_ID", value: "", enable: false),
//            Config(name: "设备类型", key: "IOT_APP_DEV_TYPE", value: "1", enable: false),
        ]
        for cfg in defaultCfgs {
            if !allCfgs.contains(where: { $0.key == cfg.key }) {
                allCfgs.append(cfg)
            }
        }
                
        return allCfgs
    }() {
        didSet {
            let data = try? JSONEncoder().encode(allConfigs)
            UserDefaults.standard.set(data, forKey: kAllConfigKeys)
        }
    }

    // MARK: - 配置监听

    public typealias IVCfgObserver = (Config) -> Void
    
    // 添加监听者
    public static func addCfgObserver(forKey key: String, observer: @escaping IVCfgObserver) {
        self._cfgObservers.append((key, observer))
    }

    // 添加监听者，若配置已存在且打开则自动回调一次
    public static func addCfgObserverInvoke(forKey key: String, observer: @escaping IVCfgObserver) {
        addCfgObserver(forKey: key, observer: observer)
        if let cfg = allConfigs.first(where: { $0.key == key && $0.enable }) {
            observer(cfg)
        }
    }
    
    private typealias IVObsTuple = (key: String, observer: IVCfgObserver)
    private static var _cfgObservers: [IVObsTuple] = []
    private static func _cfgChangedCallback(_ cfg: Config) {
        _cfgObservers.forEach { (key, observer) in
            if cfg.key == key {
                observer(cfg)
            }
        }
    }
    
    // MARK: - 配置操作
    
    static func addCfg(_ cfg: Config) {
        if let idx = allConfigs.firstIndex(where: { $0.name == cfg.name }) {
            allConfigs[idx] = cfg
        } else {
            allConfigs.append(cfg)
        }
        _cfgChangedCallback(cfg)
    }

    static func deleteCfg(_ cfg: Config) {
        if let idx = allConfigs.firstIndex(where: { $0.name == cfg.name }) {
            enableCfg(cfg.name, false)
            allConfigs.remove(at: idx)
        }
    }

    static func updateCfg(_ name: String, _ newCfg: Config) {
        if let idx = allConfigs.firstIndex(where: { $0.name == name }) {
            allConfigs[idx] = newCfg
            _cfgChangedCallback(allConfigs[idx])
        }
    }

    static func enableCfg(_ name: String, _ enable: Bool) {
        if let idx = allConfigs.firstIndex(where: { $0.name == name }) {
            allConfigs[idx].enable = enable
            _cfgChangedCallback(allConfigs[idx])
        }
    }
    
    static func existsCfg(_ name: String) -> Bool {
        return allConfigs.contains(where: { $0.name == name })
    }
        
    // MARK: - 获取配置开关

    /// 对应键值的开关状态
    /// - Parameter key: 键
    /// - Returns: nil:不存在，非nil：开关
    public static func cfgEnable(forKey key: String) -> Bool? {
        return allConfigs.first(where: { $0.key == key })?.enable
    }
    
    /// 对应键值的开关状态
    /// - Parameter name: 名称
    /// - Returns: nil:不存在，非nil：开关
    public static func cfgEnable(forName name: String) -> Bool? {
        return allConfigs.first(where: { $0.name == name })?.enable
    }

    /// 对应键值的开关状态
    /// - Parameter name: 名称
    /// - Returns: bool 
    @objc public static func cfgEnableOC(forName name: String) -> Bool {
         return cfgEnable(forName: name) ?? false
    }
    
    // MARK: - 获取配置值

    /// 获取配置的值
    /// - Parameter key: 键
    /// - Returns: 值
    public static func cfgValue(forKey key: String) -> String? {
        return allConfigs.first(where: { $0.key == key && $0.enable })?.value
    }
    
    /// 获取配置的值
    /// - Parameter name: 名称
    /// - Returns: 值
    public static func cfgValue(forName name: String) -> String? {
        return allConfigs.first(where: { $0.name == name && $0.enable })?.value
    }

}
