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
        // NOTE: I do not think a viewDidLoad should look like this. Code under comments may be refactored into functions; however, this works for turorial purposes.
        
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
        
        // set up colored subtitle string.
        let mySubtitle = NSMutableAttributedString(string: "Gravel, Asphalt, Soil")
        mySubtitle.addAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], range: NSRange(location: 0, length: 6))
        mySubtitle.addAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], range: NSRange(location: 8, length: 7))
        mySubtitle.addAttributes([NSForegroundColorAttributeName : UIColor.greenColor()], range: NSRange(location: 17, length: 4))
        
        // add pin to map
        let pin = CustomAnnotation(titleLabel: "Im Here!", subtitleLabel: mySubtitle)
        pin.coordinate = locationManager.location!.coordinate
        mapView.addAnnotation(pin)
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

