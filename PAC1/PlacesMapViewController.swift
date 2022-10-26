//
//  MapViewController.swift
//  PAC1
//
//  Created by Jordi Tejedo on 27/9/22.
//

import UIKit
import MapKit

class MyMKPointAnnotation: MKPointAnnotation {
    var id: String = ""
}

class PlacesMapViewController : UIViewController, MKMapViewDelegate, ManagerPlacesObserver {
    
    @IBOutlet weak var mapView: MKMapView!
        
    var locationManager = CLLocationManager()
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        setupActivityIndicator()
        
        loadAnnotations()
        
        ManagerPlaces.shared().addObserver(object:self)
    }
    
    func loadAnnotations() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            ManagerPlaces.shared().places.forEach { place in
                let annotation = MyMKPointAnnotation()
                annotation.id = place.id
                annotation.title = place.name
                annotation.subtitle = place.description
                annotation.coordinate = place.location
                self.mapView.addAnnotation(annotation)
            }
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func setupActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromPlacesMapToPlaceDetails") {
            let placeDetailsViewController = segue.destination as! PlaceDetailsViewController
            placeDetailsViewController.id = sender as! String
        }
    }
    
    func onPlacesChange() {
        loadAnnotations()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "fromPlacesMapToPlaceDetails", sender: (view.annotation as! MyMKPointAnnotation).id)
    }
}
