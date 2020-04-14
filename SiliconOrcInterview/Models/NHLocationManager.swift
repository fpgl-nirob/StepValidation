//
//  NHLocationManager.swift
//  quran-ios
//
//  Created by mac pro-t1 on 5/22/19.
//  Copyright © 2019 mac pro-t1. All rights reserved.
//

import UIKit
import CoreLocation

final class NHLocationManager: CLLocationManager {
    static let shared = NHLocationManager()
    
    private override init() {
        super.init()
    }
    
    func setupLocationManager() {
        self.desiredAccuracy = kCLLocationAccuracyBest
        self.requestWhenInUseAuthorization()
        self.distanceFilter = 50
        self.startUpdatingLocation()
        self.delegate = self
    }
    
    func isAuthorizedLocation() -> Bool {
        if NHLocationManager.locationServicesEnabled() {
            if NHLocationManager.authorizationStatus() == .authorizedAlways || NHLocationManager.authorizationStatus() == .authorizedWhenInUse {
                return true
            }
        }
        return false
    }
    
    func isDeniedLocation() -> Bool {
        if NHLocationManager.locationServicesEnabled() {
            if NHLocationManager.authorizationStatus() == .denied || NHLocationManager.authorizationStatus() == .restricted {
                return true
            }
        }
        return false
    }
    
    func isNotDeterminedLocation() -> Bool {
        if NHLocationManager.locationServicesEnabled() {
            if NHLocationManager.authorizationStatus() == .notDetermined {
                return true
            }
        }
        return false
    }
        
}

extension NHLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations \(self.location?.coordinate.latitude ?? 0)")
        self.stopUpdatingLocation()
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error.localizedDescription)")
        self.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization status: \(status.rawValue) isEnabled: \(NHLocationManager.locationServicesEnabled()) auth status: \(NHLocationManager.authorizationStatus().rawValue)")
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.stopUpdatingLocation()
        }
    }
}
