//
//  Place.swift
//  PAC1
//
//  Created by Jordi Tejedo on 23/9/22.
//

import Foundation
import MapKit

enum PlacesTypes: String, CaseIterable
{
    case GenericPlace = "Generic"
    case TouristicPlace = "Touristic"
}

class Place {
    var id: String = ""
    var type: PlacesTypes = .GenericPlace
    var name: String = ""
    var description: String = ""
    var location: CLLocationCoordinate2D!
    var image:Data? = nil
    
    init() {
        self.id = UUID().uuidString
    }

    init(name:String, description:String, image_in:Data?) {
        self.id = UUID().uuidString
        self.name = name
        self.description = description
        self.image = image_in
    }

    init(type:PlacesTypes, name:String, description:String, image_in:Data?) {
        self.id = UUID().uuidString
        self.type = type
        self.name = name
        self.description = description
        self.image = image_in
    }
    
    init(type:PlacesTypes, name:String, description:String, image_in:Data?, location:CLLocationCoordinate2D) {
        self.id = UUID().uuidString
        self.type = type
        self.name = name
        self.description = description
        self.location = location
        self.image = image_in
    }
}