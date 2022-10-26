//
//  ManagerPlaces.swift
//  PAC1
//
//  Created by Jordi Tejedo on 23/9/22.
//

import Foundation

class ManagerPlaces: Codable {
    
    var places = [Place]()
    
    func append(_ place: Place) {
        places.append(place)
    }
    
    func getCount() -> Int {
        return places.count
    }
    
    func getItemAt(index: Int) -> Place {
        return places[index]
    }
    
    func getItemBy(id: String) -> Place {
        return places.first { $0.id == id }!
    }
    
    func remove(_ place: Place) {
        places.removeAll { $0.id == place.id }
    }
    
    func update(_ place: Place) {
        let placeIndex = places.firstIndex(where: { $0.id == place.id })
        
        if (placeIndex != nil) {
            places[placeIndex!] = place
        }
    }
    
    private static var sharedManagerPlaces: ManagerPlaces = {
        var singletonManager:ManagerPlaces?
        singletonManager = load()
        if(singletonManager == nil) {
            singletonManager = ManagerPlaces()
        }
        
        return singletonManager!
    }()
    
    
    class func shared() -> ManagerPlaces {
        return sharedManagerPlaces
    }
    
    public var m_observers = Array<ManagerPlacesObserver>()
    
    public func addObserver(object: ManagerPlacesObserver) {
        m_observers.append(object)
    }
    
    public func updateObservers() {
        for observer in m_observers {
            observer.onPlacesChange()
        }
    }
    
    func getPathImage(place: Place) -> String {
        return FileSystem.GetPathImage(id: place.id)
    }
    
    enum CodingKeys: String, CodingKey {
        case places
    }
    
    enum PlacesTypeKey: CodingKey {
        case type
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:CodingKeys.self)
        try container.encode(places, forKey: .places)
    }
    
    func decode(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy:CodingKeys.self)
        places = [Place]()
        var objectsArrayForType = try container.nestedUnkeyedContainer(forKey: CodingKeys.places)
        var tmp_array = objectsArrayForType
        while(!objectsArrayForType.isAtEnd) {
            let object = try objectsArrayForType.nestedContainer(keyedBy: PlacesTypeKey.self)
            let type = try object.decode(PlacesTypes.self,forKey: PlacesTypeKey.type)
            switch type {
                case PlacesTypes.TouristicPlace:
                    self.append(try tmp_array.decode(PlaceTourist.self))
                default :
                    self.append(try tmp_array.decode(Place.self))
            }
        }
    }
    
    func store() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            for place in places {
                if(place.image != nil){
                    FileSystem.WriteData(id:place.id,image:place.image!)
                    place.image = nil;
                }
            }
            FileSystem.Write(data: String(data: data, encoding:.utf8)!)
        }
        catch {
        }
    }
    
    static func load() -> ManagerPlaces?
    {
        var resul:ManagerPlaces? = nil
        let data_str = FileSystem.Read()
        if(data_str != "") {
            do {
                let decoder = JSONDecoder()
                let data:Data = Data(data_str.utf8)
                resul = try decoder.decode(ManagerPlaces.self,from:data)
            } catch {
                resul = nil
            }
        }
        return resul
    }
}

protocol ManagerPlacesObserver {
    func onPlacesChange()
}
