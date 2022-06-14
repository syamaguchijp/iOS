//
//  ViewController.swift
//  Geofence
//
//  Created by Yamaguchi on 2022/06/11.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    private let locationObserver = LocationObserver()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationObserver.delegate = self
        locationObserver.start()
    }

    func sendNotification(title: String, message: String) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

extension ViewController: LocationObserverDelegate {
    
    func LocationObserverDidEnterRegion(region: CLRegion) {
        
        sendNotification(title: "EnterRegion", message: region.identifier)
    }
    
    func LocationObserverDidExitRegion(region: CLRegion) {
        
        sendNotification(title: "ExitRegion", message: region.identifier)
    }
    
    func LocationObserverDidVisit(visit: CLVisit) {
        
        sendNotification(title: "Visit", message: "from \(visit.arrivalDate) to \(visit.departureDate) coordinate = \(visit.coordinate)")
    }
}

