//
//  LocationObserver.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/20.
//

import UIKit
import CoreLocation

protocol LocationObserverDelegate: AnyObject {
    func LocationObserverDidUpdate(location: CLLocation)
}

class LocationObserver: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: LocationObserverDelegate?
    private let locationManager = CLLocationManager()
    private let significantLocationManager = CLLocationManager()
    
    func start() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.delegate = self
        significantLocationManager.delegate = self
        
        let status = locationManager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            stopLocationManager()
            startLocationManager()
        } else {
            startAuthorization()
        }
    }
    
    private func startAuthorization() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }
    
    private func startLocationManager() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        // GPS
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100.0
        locationManager.startUpdatingLocation()
        
        // Significant
        significantLocationManager.startMonitoringSignificantLocationChanges()
    }
    
    private func stopLocationManager() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        // GPS
        locationManager.stopUpdatingLocation()
        
        // Significant
        significantLocationManager.stopMonitoringSignificantLocationChanges()
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager,
                didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.first

        if let location = location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            Log.log("\(NSStringFromClass(type(of: self))) \(#function) lat=\(latitude) lon=\(longitude)")
            Log.logLocation(location)
            delegate?.LocationObserverDidUpdate(location: location)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let status = manager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            stopLocationManager()
            startLocationManager()
        }
    }
}
