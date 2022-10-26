//
//  ManagerLocation.swift
//  MyPlaces
//

//  Copyright © 2018 UOC. All rights reserved.
//

import Foundation
import MapKit
import UserNotifications

// Dummy class
class ManagerLocation : NSObject,CLLocationManagerDelegate
{

    static var pos:Int = 0
    static var locations:[CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 41.387834, longitude: 2.170130),CLLocationCoordinate2D(latitude: 41.387834, longitude: 2.170130),CLLocationCoordinate2D(latitude: 41.391980, longitude: 2.196036)]
    
    /*
    static func GetLocation()->CLLocationCoordinate2D
    {
        pos += 1
        if(pos>=locations.count) {
            pos = 0
        }
        
        return locations[pos]
        
    }
    */
    // **********************
    
     var m_locationManager:CLLocationManager!
    
    var firsTime:Bool = true
    
    
    private static var sharedManagerLocation: ManagerLocation = {
        
        var singletonManager:ManagerLocation?
        
        
        if(singletonManager == nil) {
            singletonManager = ManagerLocation()
            
            singletonManager!.m_locationManager =  CLLocationManager()
            
            singletonManager!.m_locationManager.delegate = singletonManager
            
            
            
            singletonManager!.m_locationManager.allowsBackgroundLocationUpdates = true
            
            
            singletonManager!.m_locationManager.distanceFilter = 500 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
            
            singletonManager!.m_locationManager.desiredAccuracy = kCLLocationAccuracyBest // Determining a location with greater accuracy requires more time and more power.
            
            let status:CLAuthorizationStatus = CLLocationManager.authorizationStatus()
            
            
            /*
 
 access privacy-sensitive data without a usage description. The app's Info.plist must contain an “NSLocationWhenInUseUsageDescription” key with a string value explaining to the user how the app uses this data
 
 */
            
            if (status == CLAuthorizationStatus.notDetermined){
                singletonManager!.m_locationManager.requestWhenInUseAuthorization()
            }
            else{
                singletonManager!.m_locationManager.startUpdatingLocation()
                singletonManager!.startLocation()
                
            }
            
            // ********************************************
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge])
            { (granted, error) in
                // Enable or disable features based on authorization.
            }
            
        }
        
        return singletonManager!
    }()
    
    
    class func shared() -> ManagerLocation {
        return sharedManagerLocation
    }
    
    func startLocation()
    {
        
        self.m_locationManager.startUpdatingLocation()
        
    }
    
    public func GetLocation()->CLLocationCoordinate2D
    {
    
        return (self.m_locationManager!.location?.coordinate)!
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let location:CLLocation = locations[locations.endIndex-1]
        
        if(firsTime){
            
            let content = UNMutableNotificationContent()
            content.title = "MyPlaces Title"
            content.subtitle = "MyPlaces Subtitle"
            content.body = "MyPlaces Body"
            content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10,
                                                            repeats: false)
            
            let requestIdentifier = "NotificationMyPlaces"
            let request = UNNotificationRequest(identifier: requestIdentifier,
                                                content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request,
                                                   withCompletionHandler: { (error) in
                                                    // Handle error
            })
            
            firsTime = false;
        }
        
        
    }
}
