//
//  ViewController.swift
//  colored-subtitle-map-annotation-view
//
//  Created by Eric Mentele on 4/27/16.
//  Copyright © 2016 Eric Mentele. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Must add NSLocationWhenInUseUsageDescription to info.plist
        locationManager.startUpdatingLocation()
        
        // set up map view
        mapView.delegate = self
        
        if let locatonCooridinate = locationManager.location?.coordinate {
            dispatch_async(dispatch_get_main_queue(), {
                self.mapView.setCenterCoordinate(locatonCooridinate, animated: true)
            })
        }
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        <#code#>
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

