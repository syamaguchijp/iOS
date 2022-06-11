//
//  LocationObserver.swift
//  Geofence
//
//  Created by Yamaguchi on 2022/06/11.
//

import UIKit
import CoreLocation

// 領域観測
protocol LocationObserverDelegate: AnyObject {
    func LocationObserverDidEnterRegion(region: CLRegion)
    func LocationObserverDidExitRegion(region: CLRegion)
}

class LocationObserver: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: LocationObserverDelegate?
    private let locationManager = CLLocationManager()
    private var moniteringRegion = CLCircularRegion()
    
    func start() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.delegate = self
        
        let moniteringCordinate = CLLocationCoordinate2DMake(35.0, 139.0)
        moniteringRegion = CLCircularRegion.init(center: moniteringCordinate, radius: 100.0, identifier: "region1")
        
        let status = locationManager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            stopRegionMonitoring()
            startRegionMonitoring()
        } else {
            startAuthorization()
        }
    }
    
    private func startAuthorization() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.requestAlwaysAuthorization()
    }
    
    private func startRegionMonitoring() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.startMonitoring(for: moniteringRegion)
    }
    
    private func stopRegionMonitoring() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.stopMonitoring(for: moniteringRegion)
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        delegate?.LocationObserverDidEnterRegion(region: region)
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        delegate?.LocationObserverDidExitRegion(region: region)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let status = manager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            stopRegionMonitoring()
            startRegionMonitoring()
        }
    }
}

