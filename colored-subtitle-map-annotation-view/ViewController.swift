//
//  ViewController.swift
//  colored-subtitle-map-annotation-view
//  Created with the help of this stack overflow link: https://stackoverflow.com/questions/29796159/how-to-set-xib-interface-as-a-custom-callout-view
//
//  Created by Eric Mentele on 4/27/16.
//  Copyright © 2016 Eric Mentele. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    // This is for getting the user location for an annotation pin position. Must add NSLocationWhenInUseUsageDescription to info.plist
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // NOTE: I do not think a viewDidLoad should look like this. Code under comments may be refactored into functions; however, this works for turorial purposes.
        
        // set up location manager
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // set up map view
        mapView.delegate = self
        
        // set up colored subtitle string.
        let mySubtitle = NSMutableAttributedString(string: "Gravel, Asphalt, Soil")
        mySubtitle.addAttributes([NSForegroundColorAttributeName : UIColor.redColor()], range: NSRange(location: 0, length: 6))
        mySubtitle.addAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], range: NSRange(location: 8, length: 7))
        mySubtitle.addAttributes([NSForegroundColorAttributeName : UIColor.greenColor()], range: NSRange(location: 17, length: 4))
        
        // add pin to map
        let pin = CustomAnnotation(titleLabel: "Im Here!", subtitleLabel: mySubtitle)
        
        if let location = locationManager.location {
            pin.coordinate = location.coordinate
            mapView.addAnnotation(pin)
        } else {
            pin.coordinate = CLLocationCoordinate2D(latitude: -80.346553, longitude: 68.073319)
            mapView.addAnnotation(pin)
        }
        
        // Move map to pin.
        dispatch_async(dispatch_get_main_queue(), {
            self.mapView.setCenterCoordinate(pin.coordinate, animated: true)
        })
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let customView = (NSBundle.mainBundle().loadNibNamed("AnnotationView", owner: self, options: nil))[0] as! CustomCalloutView
        
        // Center the callout view over the annotation pin.
        var calloutViewFrame = customView.frame;
        calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 15, -calloutViewFrame.size.height - 10);
        customView.frame = calloutViewFrame;
        
        // update the views text values with the custom annotations properties
        let customAnnotation = view.annotation as! CustomAnnotation
        customView.titleLabel.text = customAnnotation.titleLabel
        customView.subtitleLabel.attributedText = customAnnotation.subtitleLabel
        view.addSubview(customView)
        
        // Zoom in the map view to .69 miles centered on the annotation pin.
        let spanX = 0.01
        let spanY = 0.01
        
        let newRegion = MKCoordinateRegion(center:customAnnotation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        
        dispatch_async(dispatch_get_main_queue()) {
            self.mapView.setRegion(newRegion, animated: true)
            
        }
    }
}

