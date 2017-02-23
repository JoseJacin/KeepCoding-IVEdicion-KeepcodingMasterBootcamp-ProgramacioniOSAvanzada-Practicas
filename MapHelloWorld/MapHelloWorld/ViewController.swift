//
//  ViewController.swift
//  MapHelloWorld
//
//  Created by Jose Sanchez Rodriguez on 24/2/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        
        // Esto visa a su delegado que va a empezar a actualizar la localización
        locationManager?.startUpdatingLocation()
    }

    @IBAction func centerButtonClicked(_ sender: Any) {
        let londonLocation = CLLocation(latitude: 51.509865, longitude: -0.118092)
        self.mapView.setCenter(londonLocation.coordinate, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.first.debugDescription)
    }
}

