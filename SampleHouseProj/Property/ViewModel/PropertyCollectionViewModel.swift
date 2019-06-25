//
//  PropertyCollectionViewModel.swift
//  SampleHouseProj
//
//  Created by amee on 13/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit

class PropertyCollectionViewModel {
    
    private let propertyCollectionModel: PropertyCollectionModel = PropertyCollectionModel()
    var propertyCollectionCellViewModels: Array<PropertyCollectionViewCellViewModel> = Array()
    var currentSelectedTab: SelectedTab = .collection
    
    init() {
        loadPropertyData()
    }    
    
    //MARK: Set Tab Value
    /**
     This method sets value for current selected tabs
     
     - Parameter selectedTab: Selected tab value.
     */
    func setSelectedTab(selectedTab: SelectedTab) {
        currentSelectedTab = selectedTab
    }
}

//MARK: Data getters
extension PropertyCollectionViewModel {
    //MARK: Getters for Datasource Array
    /**
     This method returns all CollectionViewCellModels for all house properties
     
     - Returns: Array of all house property cell view models
     */
    private func getAllPropertyList(searchText: String) -> Array<PropertyCollectionViewCellViewModel> {
        return searchText.isEmpty ? propertyCollectionCellViewModels : propertyCollectionCellViewModels.filter { return isPropertyContainsMatchingText(parentString: ("\($0.getLocation() ?? "") \($0.getAddress() ?? "")"), subString: searchText) }
    }
    
    /**
     This method returns all CollectionViewCellModels for favourite house properties
     
     - Returns: Array of favourite house property cell view models
     */
    private func getFavouritePropertyList(searchText: String) -> Array<PropertyCollectionViewCellViewModel> {
        let favouritePropertiesList = propertyCollectionCellViewModels.filter { $0.getIsFavourite() == true }
        return searchText.isEmpty ? favouritePropertiesList : favouritePropertiesList.filter { return isPropertyContainsMatchingText(parentString: ("\($0.getLocation() ?? "") \($0.getAddress() ?? "")"), subString: searchText) }
    }
    
    /**
     This method returns all CollectionViewCellModels for self Added house properties
     
     - Returns: Array of self added house property cell view models
     */
    private func getMyHousePropertyList(searchText: String) -> Array<PropertyCollectionViewCellViewModel> {
        let myHousePropertiesList = propertyCollectionCellViewModels.filter { $0.getIsMyHouse() == true }
        return searchText.isEmpty ? myHousePropertiesList : myHousePropertiesList.filter { return isPropertyContainsMatchingText(parentString: ("\($0.getLocation() ?? "") \($0.getAddress() ?? "")"), subString: searchText) }
    }

    /**
     This method returns all CollectionViewCellModels for non-self Added house properties
     
     - Returns: Array of non-self added house property cell view models
     */
    private func getMissingPropertyList(searchText: String) -> Array<PropertyCollectionViewCellViewModel> {
        let myHousePropertiesList = propertyCollectionCellViewModels.filter { $0.getIsMyHouse() != true }
        return searchText.isEmpty ? myHousePropertiesList : myHousePropertiesList.filter { return isPropertyContainsMatchingText(parentString: ("\($0.getLocation() ?? "") \($0.getAddress() ?? "")"), subString: searchText) }
    }

    /**
     This method provides diffrent Datasource for each user selected tab
     
     - Returns: Array of all house property cell view models
     */
    func getPropertyList(searchText: String) -> Array<PropertyCollectionViewCellViewModel> {
        switch currentSelectedTab {
        case .collection:
            return getAllPropertyList(searchText: searchText)
        case .favourite:
            return getFavouritePropertyList(searchText: searchText)
        case .myHouse:
            return getMyHousePropertyList(searchText: searchText)
        case .duplicate:
            return [PropertyCollectionViewCellViewModel]()
        case .missing:
            return getMissingPropertyList(searchText: searchText)
        }
    }
}

//MARK: Search Helpers
extension PropertyCollectionViewModel {
    /**
     This method check if string contains substring or not
     
     - Parameter parentString: Main string in which we need to search.
     - Parameter subString: String which we need to search.
     - Returns: Boolean value as tru or false.
     */
    private func isPropertyContainsMatchingText(parentString: String, subString: String) -> Bool {
        let range = parentString.range(of: subString, options: .caseInsensitive)
        return range != nil
    }
}

//MARK: DataSource updation
extension PropertyCollectionViewModel {
    //MARK: Create/Update Cell View Models
    /**
     This method cleanup datasource and reload all data from database, uses core data for operations
     */
    func updateDataSource() {
        if !propertyCollectionCellViewModels.isEmpty {
            propertyCollectionCellViewModels.removeAll()
        }
        guard let propertyList: [Property] = CoreDataManager.sharedManager.fetchHouseProperty(propertyNumber: nil) else {
            return
        }
        for propertyLocalObj in propertyList {
            let propertyNumber: String? = propertyLocalObj.propertyNumber
            let imageUrl: String? = propertyLocalObj.imageUrl
            let location: String? = propertyLocalObj.location
            let address: String? = propertyLocalObj.address
            let isFavourite: Bool? = propertyLocalObj.isFavourite
            let isMyHouse: Bool? = propertyLocalObj.isMyHouse
            let latitudeAndLongitude: String? = propertyLocalObj.latitudeAndLongitude
            propertyCollectionCellViewModels.append(PropertyCollectionViewCellViewModel(propertyImageUrl: imageUrl, propertyNumber: propertyNumber, location: location, address: address, isFavourite: isFavourite, isMyHouse: isMyHouse, latitudeAndLongitude: latitudeAndLongitude))
        }
    }
    
    //MARK: Initially Load and Save data
    /**
     This method gets data from Model Class and save it Database using core data,
     then it proceed further to updates the datasource from database by doing call
     */
    private func loadPropertyData() {
        let coreDataSharedObject = CoreDataManager.sharedManager        
        guard let propertyList: [Property] = coreDataSharedObject.fetchHouseProperty(propertyNumber: nil), propertyList.isEmpty else {
            updateDataSource()
            return
        }
        let homeData: Array<Dictionary<String, Any>> = propertyCollectionModel.getHouseInformation()
        for propertyLocalObj in homeData {
            let propertyNumber: String? = propertyLocalObj[kPropertyNumber] as? String
            let imageUrl: String? = propertyLocalObj[kImageUrl] as? String
            let location: String? = propertyLocalObj[kLocation] as? String
            let address: String? = propertyLocalObj[kAddress] as? String
            let isFavourite: Bool? = propertyLocalObj[kIsFavourite] as? Bool
            let isMyHouse: Bool? = propertyLocalObj[kIsMyHouse] as? Bool
            let latitudeAndLongitude: String? = propertyLocalObj[kLatitudeAndLongitude] as? String
            if coreDataSharedObject.insertHouseProperty(propertyNumber: propertyNumber, imageUrl: imageUrl, location: location, address: address, isFavourite: isFavourite, isMyHouse: isMyHouse, latitudeAndLongitude: latitudeAndLongitude) == nil {
                //TODO: Need to do error handling
            }
        }
        updateDataSource()
    }
}
