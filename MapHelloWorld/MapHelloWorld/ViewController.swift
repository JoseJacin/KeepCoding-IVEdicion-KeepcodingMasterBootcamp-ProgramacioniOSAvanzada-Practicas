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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager: CLLocationManager?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        
        // Esto visa a su delegado que va a empezar a actualizar la localización
        locationManager?.startUpdatingLocation()
        
        // Se indica al mapView que su delegado soy yo
        self.mapView.delegate = self
        
        // Se crean anotaciones para la demostración
        addSomePinsToMap()
    }
    
    func addSomePinsToMap() {
        let a1 = MapPin(coordinate: CLLocationCoordinate2D(latitude: 51.5091, longitude: -0.118))
        a1.title = "Pin 1"
        a1.subtitle = "Subtitle 1"
        self.mapView.addAnnotation(a1)
        
        let a2 = MapPin(coordinate: CLLocationCoordinate2D(latitude: 51.5071, longitude: -0.114))
        a2.title = "Pin 2"
        a2.subtitle = "Subtitle 2"
        self.mapView.addAnnotation(a2)
    }

    @IBAction func centerButtonClicked(_ sender: Any) {
        let londonLocation = CLLocation(latitude: 51.509865, longitude: -0.118092)
        //self.mapView.setCenter(londonLocation.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: londonLocation.coordinate, span: MKCoordinateSpanMake(0.2, 0.2))
        
        self.mapView.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations.first.debugDescription)
    }
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        print("Start loading")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("Finish loading")
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("Start rendering")
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        print("Finish rendering")
    }
    
    // Función que según se va moviendo el mapa, va pintanto los pines
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Se asegura que la anotación no es de tipo MKUserLocation para no hacer nada con ella
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView: MKAnnotationView?
        
        let reuseIdentifier = "myAnnotationView"
        // Si retorna uno quiere decir que hay uno que lo ha creado anteriormente pero que no se está viendo ahora
        if let dequeueAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) {
            // Se puede reusar un pin (ANootationView) que ahora mismo no se ve en pantalla
            annotationView = dequeueAnnotationView
            annotationView?.annotation = annotation
        } else {
            // No se puede reutilizar, por lo que hay que crear uno
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        if let annotationView = annotationView {
            // Se le indica que puede mostrar el Callout (Globito)
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "Pin")
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Selected \(view.annotation?.title)")
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("Deselected \(view.annotation?.title)")
    }
    
    // Función que se ejecuta cuando se pulsa sobre el botón Información de una anotación
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Callout info tapped \(view.annotation?.title)")
    }
}

// Clase que pone un pin (anotación del mapa) sobre el mapa
class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    // El modelo se le pasa a la clase y después se inicializa en el init
    //let myModelObject: Notebook
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    
}

