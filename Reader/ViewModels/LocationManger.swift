//
//  LocationManager.swift
//  Reader
//
//  Created by V™️ on 2024/7/12.
//

import Combine
import CoreLocation
import Foundation
import MapKit

class LocationManger: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManger = CLLocationManager()

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.9055, longitude: 116.3976),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )

    override init() {
        super.init()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.coordinate.latitude, longitude: location.coordinate.longitude
            ),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    }
    
    
}
