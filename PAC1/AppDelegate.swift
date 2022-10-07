//
//  AppDelegate.swift
//  PAC1
//
//  Created by Jordi Tejedo on 23/9/22.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let managerPlaces = ManagerPlaces.Shared()
        
        managerPlaces.append(Place(type: PlacesTypes.TouristicPlace, name: "Sagrada Família", description: "Basílica católica de Barcelona, diseñada por el arquitecto Antoni Gaudí.", image_in: UIImage(named:"SagradaFamilia.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 41.4036299, longitude: 2.1743558)))
        managerPlaces.append(Place(type: PlacesTypes.GenericPlace, name: "Can Solé", description: "Surtidos de marisco, paellas y jarras de sangría en un restaurante sencillo de toda la vida.", image_in: UIImage(named:"CanSole.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 41.3788768, longitude: 2.1883984)))
        managerPlaces.append(Place(type: PlacesTypes.GenericPlace, name: "Fernando Buesa Arena", description: "Pabellón multiusos de Vitoria, utilizado por el Baskonia para jugar sus partidos de competición oficial.", image_in: UIImage(named:"FernandoBuesaArena.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 42.8640931, longitude: -2.6438329)))
        managerPlaces.append(Place(type: PlacesTypes.GenericPlace, name: "Canillo", description: "Parroquia de Andorra.", image_in: UIImage(named:"Canillo.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 42.5665313, longitude: 1.5977744)))
        managerPlaces.append(Place(type: PlacesTypes.TouristicPlace, name: "La Rambla", description: "Emblemático paseo de la ciudad de Barcelona que discurre entre la plaza de Cataluña, centro neurálgico de la ciudad, y el puerto antiguo.", image_in: UIImage(named:"LaRambla.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 41.3856087, longitude: 2.169913)))
        managerPlaces.append(Place(type: PlacesTypes.GenericPlace, name: "Pizzeria Trattoria La Briciola", description: "Pizzería pequeña de ambiente acogedor, famosa por sus pizzas amasadas a mano y sus postres clásicos italianos.", image_in: UIImage(named:"LaBriciola.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 41.373773, longitude: 2.1343569)))
        managerPlaces.append(Place(type: PlacesTypes.GenericPlace, name: "Centro Comercial Finestrelles", description: "Complejo comercial al aire libre con tiendas de moda, calzado y electrónica, un hipermercado y restaurantes de comida rápida.", image_in: UIImage(named:"CentroComercialFinestrelles.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 41.3775385, longitude: 2.0971367)))
        managerPlaces.append(Place(type: PlacesTypes.TouristicPlace, name: "Playa de la Barceloneta", description: "Playa popular para bañarse y tomar el sol, con numerosos servicios como socorristas, alquiler de tumbonas y Wi‑Fi.", image_in: UIImage(named:"PlayaDeLaBarceloneta.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 41.3768782, longitude: 2.1391793)))
        managerPlaces.append(Place(type: PlacesTypes.TouristicPlace, name: "Park Güell", description: "Edificios, escaleras y esculturas con mosaicos en un parque verde con el museo de Gaudí y vistas panorámicas.", image_in: UIImage(named:"ParkGuell.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 41.4009645, longitude: 2.1400142)))
        managerPlaces.append(Place(type: PlacesTypes.TouristicPlace, name: "Parque de atracciones Tibidabo", description: "Parque inaugurado en 1868 con 25 atracciones, además de restaurantes, zonas de pícnic y vistas a la ciudad.", image_in: UIImage(named:"ParqueDeAtraccionesTibidabo.jpg")?.pngData(), location: CLLocationCoordinate2D(latitude: 41.405419, longitude: 2.0991561)))
        
        return true
    }
}

