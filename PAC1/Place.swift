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
    
    //******************************************
    // Serialization
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case name
        case description
        case location
        case image
    }
    
    func decode(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        //type = try container.decode(PlacesTypes.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        //location = try container.decode(CLLocationCoordinate2D.self, forKey: .location)
        image = try container.decode(Data.self, forKey: .image)
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        try decode(from: decoder)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        //try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        //try container.encode(location, forKey: .location)
        try container.encode(image, forKey: .image)
    }
}
