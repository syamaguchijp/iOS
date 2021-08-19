//
//  WifiObserver.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/14.
//

import UIKit
import CoreLocation
import Reachability
import SystemConfiguration.CaptiveNetwork

class WifiObserver: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private let reachability = try! Reachability()
    
    func start() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        checkAuthorization()
    }
    
    // iOS13からはWi-Fiに関して位置情報許諾が必要となった
    private func checkAuthorization() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            startWatchingWifi()
        } else {
            print("requestWhenInUseAuthorization")
            locationManager.requestWhenInUseAuthorization()
        }
    }

    private func startWatchingWifi() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
        
        getCurrentWifiSSID()
    }
    
    @objc private func reachabilityChanged(note: Notification) {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let reachability = note.object as! Reachability

        switch reachability.connection {
            case .wifi:
                print("Reachable via WiFi")
            case .cellular:
                print("Reachable via Cellular")
            case .unavailable:
                print("Network not reachable")
            case .none:
                print("none")
        }
    }
    
    func stop() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        stopWatchingWifi()
    }
    
    private func stopWatchingWifi() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        reachability.stopNotifier()
    }
    
    // MARK: Wi-Fi !!!!! Not work anymore !!!!!
    
    func getCurrenInterfaceInfo() -> NSDictionary? {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    return interfaceInfo
                }
            }
        }
        return nil
    }
    
    func getCurrentWifiSSID() -> String? {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let interfaceInfo = getCurrenInterfaceInfo()
        if let interfaceInfo = interfaceInfo {
            let ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
            Log.log("\(NSStringFromClass(type(of: self))) \(#function) ssid=\(ssid)")
            return ssid
        }
        return nil
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            startWatchingWifi()
        }
    }
 
}
