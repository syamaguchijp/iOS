//
//  BeaconObserver.swift
//  Sample
//
//  Created by Yamaguchi on 2022/07/01.
//

import UIKit
import CoreLocation

class BeaconObserver: NSObject, CLLocationManagerDelegate {
  
    private let beaconUUID = "XXXXXXXXXXXXXXX"
    private let beaconReagionID = "MyBeaconID"
    private let locationManager = CLLocationManager()
    private var beaconRegion: CLBeaconRegion?
    
    func start() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.delegate = self
        
        let status = locationManager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            stopLocationManager()
            startLocationManager()
        } else {
            startAuthorization()
        }
    }
    
    private func startAuthorization() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    private func startLocationManager() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")

        let uuid = UUID(uuidString: beaconUUID)
        guard let uuid = uuid else {
            return
        }
        
        beaconRegion = CLBeaconRegion(uuid: uuid, identifier: beaconReagionID)
        if let beaconRegion = beaconRegion {
            locationManager.startMonitoring(for: beaconRegion)
        }
    }
    
    private func stopLocationManager() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if let beaconRegion = beaconRegion {
            locationManager.stopMonitoring(for: beaconRegion)
        }
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let status = manager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            stopLocationManager()
            startLocationManager()
        }
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if let beaconRegion = beaconRegion {
            if #available(iOS 13.0, *) {
                locationManager.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
            } else {
                locationManager.startRangingBeacons(in: beaconRegion)
            }
        }
        sendNotification(title: "iBeacon", message:"didEnterRegion")
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if let beaconRegion = beaconRegion {
            if #available(iOS 13.0, *) {
                locationManager.stopRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
            } else {
                locationManager.stopRangingBeacons(in: beaconRegion)
            }
        }
        sendNotification(title: "iBeacon", message:"didExitRegion")
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion){
        
        //print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        for beacon in beacons {
            print("UUID=\(beacon.uuid) major=\(beacon.major) minor=\(beacon.minor) proximity=\(beacon.proximity) rssi=\(beacon.rssi)")
        }
    }
    
    // ローカル通知
    func sendNotification(title: String, message: String) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
