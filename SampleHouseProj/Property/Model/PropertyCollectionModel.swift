//
//  PropertyCollectionListModel.swift
//  SampleHouseProj
//
//  Created by amee on 13/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import Foundation

class PropertyCollectionModel {
    
    /**
     This method provides Dummy data for collection drawing as no other data source available
     
     - Returns: Array containing dictionary of key-value pairs.
     */
    func getHouseInformation() -> Array<Dictionary<String, Any>> {
        return [[kImageUrl: kHomeImageName, kPropertyNumber: propertyDummyDataArray[0], kLocation: locationDummyDataArray[0], kAddress: addressDummyDataArray[0], kIsFavourite: false, kIsMyHouse: false, kLatitudeAndLongitude: lattitudesAndLongitudeDummyDataArray[0]],
                [kImageUrl: kHomeImageName, kPropertyNumber: propertyDummyDataArray[1], kLocation: locationDummyDataArray[1], kAddress: addressDummyDataArray[1], kIsFavourite: false, kIsMyHouse: false, kLatitudeAndLongitude: lattitudesAndLongitudeDummyDataArray[1]],
                [kImageUrl: kHomeImageName, kPropertyNumber: propertyDummyDataArray[2], kLocation: locationDummyDataArray[2], kAddress: addressDummyDataArray[2], kIsFavourite: false, kIsMyHouse: false, kLatitudeAndLongitude: lattitudesAndLongitudeDummyDataArray[2]],
                [kImageUrl: kHomeImageName, kPropertyNumber: propertyDummyDataArray[3], kLocation: locationDummyDataArray[3], kAddress: addressDummyDataArray[3], kIsFavourite: false, kIsMyHouse: false, kLatitudeAndLongitude: lattitudesAndLongitudeDummyDataArray[3]],
                [kImageUrl: kHomeImageName, kPropertyNumber: propertyDummyDataArray[4], kLocation: locationDummyDataArray[4], kAddress: addressDummyDataArray[4], kIsFavourite: false, kIsMyHouse: false, kLatitudeAndLongitude: lattitudesAndLongitudeDummyDataArray[1]],
                [kImageUrl: kHomeImageName, kPropertyNumber: propertyDummyDataArray[5], kLocation: locationDummyDataArray[5], kAddress: addressDummyDataArray[5], kIsFavourite: false, kIsMyHouse: false, kLatitudeAndLongitude: lattitudesAndLongitudeDummyDataArray[5]],
                [kImageUrl: kHomeImageName, kPropertyNumber: propertyDummyDataArray[6], kLocation: locationDummyDataArray[6], kAddress: addressDummyDataArray[6], kIsFavourite: false, kIsMyHouse: false, kLatitudeAndLongitude: lattitudesAndLongitudeDummyDataArray[6]]]
    }
}
