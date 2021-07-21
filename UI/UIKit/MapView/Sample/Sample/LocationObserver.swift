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
    
    func start() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        startAuthorization()
    }
    
    private func startAuthorization() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            stopLocationManager()
            startLocationManager()
        }
    }
    
    private func startLocationManager() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100.0
        locationManager.startUpdatingLocation()
    }
    
    private func stopLocationManager() {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager,
                didUpdateLocations locations: [CLLocation]) {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        print("latitude: \(latitude!)")
        print("longitude: \(longitude!)")
        
        if let location = location {
            delegate?.LocationObserverDidUpdate(location: location)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse {
            stopLocationManager()
            startLocationManager()
        }
    }
}
