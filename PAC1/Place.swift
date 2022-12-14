//
//  Place.swift
//  PAC1
//
//  Created by Jordi Tejedo on 23/9/22.
//

import Foundation
import MapKit

enum PlacesTypes: String, CaseIterable, Codable
{
    case GenericPlace = "Generic"
    case TouristicPlace = "Touristic"
}

class Place: Codable {
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
    
    //******************************************
    // Serialization
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case description
        case latitude
        case longitude
    }
    
    func decode(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy:CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(PlacesTypes.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey:.description)
        let latitude = try container.decode(Double.self, forKey:.latitude)
        let longitude = try container.decode(Double.self, forKey:.longitude)
        location = CLLocationCoordinate2D(latitude: latitude,longitude: longitude)
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        try decode(from: decoder)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:CodingKeys.self)
        try container.encode(id, forKey: .id)
        // Repetir para el resto de propiedades.
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        // Para la location, grabamos sus componentes latitud y longitud por separado.
        try container.encode(location.latitude, forKey:.latitude)
        try container.encode(location.longitude, forKey:.longitude)
    }
}
