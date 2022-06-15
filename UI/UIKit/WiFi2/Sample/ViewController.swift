//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/15.
//

import UIKit
import CoreLocation
import NetworkExtension

// Capabilitiies に Access WiFi Information を追加すること

class ViewController: UIViewController, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        let status = locationManager.authorizationStatus
        if status == .authorizedWhenInUse {
            getSSID()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse {
            getSSID()
        }
    }
    
    func getSSID() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        NEHotspotNetwork.fetchCurrent { network in
            print("\(NSStringFromClass(type(of: self))) \(#function) ESSID=\(network?.ssid) BSSID=\(network?.bssid)")
        }
        
    }
}

