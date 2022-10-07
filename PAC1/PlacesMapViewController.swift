//
//  MapViewController.swift
//  PAC1
//
//  Created by Jordi Tejedo on 27/9/22.
//

import UIKit
import MapKit

protocol PlacesMapDelegate {
    func loadAnnotations()
}

class MyMKPointAnnotation: MKPointAnnotation {
    var id: String = ""
}

class PlacesMapViewController : UIViewController, PlacesMapDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
        
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
        mapView.delegate = self

        loadAnnotations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAnnotations()
    }
    
    func loadAnnotations() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        ManagerPlaces.Shared().places.forEach { place in
            let annotation = MyMKPointAnnotation()
            annotation.id = place.id
            annotation.title = place.name
            annotation.subtitle = place.description
            annotation.coordinate = place.location
            self.mapView.addAnnotation(annotation)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromPlacesMapToPlaceDetails") {
            let placeDetailsViewController = segue.destination as! PlaceDetailsViewController
            placeDetailsViewController.id = sender as! String
            placeDetailsViewController.placesMapDelegate = self
        } else if (segue.identifier == "fromPlacesMapToNewPlace") {
            let newPlaceViewController = segue.destination as! NewPlaceViewController
            newPlaceViewController.placesMapDelegate = self
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "fromPlacesMapToPlaceDetails", sender: (view.annotation as! MyMKPointAnnotation).id)
    }
}
