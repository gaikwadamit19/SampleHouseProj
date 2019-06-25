//
//  PropertyCollectionViewCellViewModel.swift
//  SampleHouseProj
//
//  Created by amee on 13/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit

class PropertyCollectionViewCellViewModel {
    
    private var propertyImageUrl: String?
    private var propertyNumber: String?
    private var location: String?
    private var address: String?
    private var isFavourite: Bool?
    private var isMyHouse: Bool?
    private var latitudeAndLongitude: String?
    
    init(propertyImageUrl: String?, propertyNumber: String?, location: String?, address: String?, isFavourite: Bool?, isMyHouse: Bool?, latitudeAndLongitude: String?) {
        self.propertyImageUrl = propertyImageUrl
        self.propertyNumber = propertyNumber
        self.location = location
        self.address = address
        self.isFavourite = isFavourite
        self.isMyHouse = isMyHouse
        self.latitudeAndLongitude = latitudeAndLongitude
    }
    
    //MARK: Getters for all properties
    /**
     This method provides image URL for cell view model
     
     - Returns: String value for property Image url.
     */
    func getPropertyImageUrl() -> String? {
        return propertyImageUrl
    }

    /**
     This method provides property number for cell view model
     
     - Returns: String value for property number.
     */
    func getPropertyNumber() -> String? {
        return propertyNumber
    }
    
    /**
     This method provides peoperty location for cell view model
     
     - Returns: String value for property location.
     */
    func getLocation() -> String? {
        return location
    }

    /**
     This method provides peoperty address for cell view model
     
     - Returns: String value for property address.
     */
    func getAddress() -> String? {
        return address
    }
    
    /**
     This method tells, is this property user favourite peoperty or not
     
     - Returns: Boolean value for favourite.
     */
    func getIsFavourite() -> Bool? {
        return isFavourite
    }
    
    /**
     This method tells, is this property self created
     
     - Returns: Boolean value for myHouse
     */
    func getIsMyHouse() -> Bool? {
        return isMyHouse
    }
    
    /**
     This method provides Latitude and Longitude of current property
     
     - Returns: String value for "latitude: longitude"
     */
    func getLatitudeAndLongitude() -> String? {
        return latitudeAndLongitude
    }
}
