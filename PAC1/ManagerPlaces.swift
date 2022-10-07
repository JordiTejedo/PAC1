//
//  ManagerPlaces.swift
//  PAC1
//
//  Created by Jordi Tejedo on 23/9/22.
//

import Foundation

class ManagerPlaces {
    
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
        
        var singletonManager:ManagerPlaces
       
        singletonManager = ManagerPlaces()
        
        return singletonManager
    }()
    
    
    class func Shared() -> ManagerPlaces {
        return sharedManagerPlaces
    }
    
    
}
