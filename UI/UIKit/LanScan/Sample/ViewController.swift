//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/15.
//

import UIKit

class ViewController: UIViewController, MMLANScannerDelegate {

    var lanScanner : MMLANScanner!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lanScanner = MMLANScanner(delegate:self)
        lanScanner.start()
    }
    
    func lanScanDidFindNewDevice(_ device: MMDevice!) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function) \(device.ipAddress) \(device.hostname) \(device.macAddress)")
    }
    
    func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
    }
    
    func lanScanProgressPinged(_ pingedHosts: Float, from overallHosts: Int) {
        
        //print("\(NSStringFromClass(type(of: self))) \(#function)")
    }
    
    func lanScanDidFailedToScan(){
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
    }

}

