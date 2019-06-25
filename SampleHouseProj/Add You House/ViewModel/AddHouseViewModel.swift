//
//  AddHouseViewModel.swift
//  SampleHouseProj
//
//  Created by amee on 15/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit
import MapKit

class AddHouseViewModel {
    
    //MARK: Add New House Property
    /**
     This method add new house property Added by user and save to database
     
     - Parameter location: Location object containing lattitude and longitude.
     - Parameter closure: Returns the True/False status and string message.
     */
    func addUsersNewHouse(location: CLLocation, closure: @escaping ((Bool, String) -> Void)) {
        let geoCoder: CLGeocoder = CLGeocoder()
        let latitude: CLLocationDegrees = location.coordinate.latitude
        let longitude: CLLocationDegrees = location.coordinate.longitude
        
        geoCoder.reverseGeocodeLocation(location) {
            (placemark, error) in
            
            guard let placeMark = placemark?.first else {
                closure(false, kNoLocationDetailsAvailable)
                return
            }
            
            let coreDataManagerSharedObject = CoreDataManager.sharedManager
            var propertyNumber: String = "1"
            if let property: Property = coreDataManagerSharedObject.fetchHouseProperty(propertyNumber: nil)?.max(by: { a, b in Int(a.propertyNumber ?? "0") ?? 0 < Int(b.propertyNumber ?? "0") ?? 0 }) {
                //Adding house number as incremental count for now
                propertyNumber = #"\#((Int(property.propertyNumber ?? "0") ?? 0) + 1)"#
            }
            
            let imageUrl: String? = kHomeImageName
            let location: String? = placeMark.name
            let address: String? = "".appendingFormat("%@, %@, %@", placeMark.locality ?? "", placeMark.administrativeArea ?? "", placeMark.subAdministrativeArea ?? "")
            let latitudeAndLongitude: String = "\(latitude): \(longitude)"
            let isFavourite: Bool? = false
            let isMyHouse: Bool? = true
            
            if coreDataManagerSharedObject.insertHouseProperty(propertyNumber: propertyNumber, imageUrl: imageUrl, location: location, address: address, isFavourite: isFavourite, isMyHouse: isMyHouse, latitudeAndLongitude: latitudeAndLongitude) == nil {
                closure(false, kHouseAddedFailedMessage)
            } else {
                closure(true, kHouseAddedSuccessMessage)
            }
        }
    }
}
