//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/20.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    private let locationObserver = LocationObserver()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        startMapView()
        startLocation()
    }
    
    func startMapView() {
        
        mapView.delegate = self
        let location = CLLocationCoordinate2DMake(35.725644500810844, 139.71476464402537)
        mapView.setCenter(location, animated:true)
        setAnnotation(location: location)
        var region = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        mapView.setRegion(region, animated:true)
        mapView.mapType = MKMapType.standard
    }
    
    private func startLocation() {
        
        locationObserver.delegate = self
        locationObserver.start()
    }
    
    private func setAnnotation(location: CLLocationCoordinate2D) {
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "現在地"
        mapView.addAnnotation(annotation)
    }
    
    private func drawPolyline() {
        
        mapView.removeOverlays(mapView.overlays)
        
        let coordinates = Log.readLocation()
        let polyLine = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapView.addOverlay(polyLine)
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        // 位置情報のログ、軌跡をすべて消す
        Log.deleteAllLocation()
        drawPolyline()
    }
}

extension ViewController: MKMapViewDelegate {
    
    // アノテーション表示直前にコールされる
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let identifier = "myAnnotation"
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView.annotation = annotation
            return annotationView
        }
        let annotationView = MKMarkerAnnotationView(
            annotation: annotation,
            reuseIdentifier: identifier
        )
        annotationView.markerTintColor = .blue
        annotationView.canShowCallout = true // 吹き出し
        return annotationView
    }
    
    // 軌跡表示直前にコールされる
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if let polyline = overlay as? MKPolyline {
            let polylineRenderer = MKPolylineRenderer(polyline: polyline)
            polylineRenderer.strokeColor = .purple
            polylineRenderer.lineWidth = 2.0
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
}

extension ViewController: LocationObserverDelegate {
    
    func LocationObserverDidUpdate(location: CLLocation) {
        
        Log.log("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let lc = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        mapView.setCenter(lc, animated:true)
        setAnnotation(location: lc)
        
        drawPolyline()
    }
}

