//
//  CoreDataManager.swift
//  SampleHouseProj
//
//  Created by amee on 14/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CoreDataManager {
    
    static let sharedManager: CoreDataManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persitentContainer = NSPersistentContainer(name: kProperty)
        persitentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                //TODO: Need to do error handling
            }
        })
        return persitentContainer
    }()
    
    //MARK: Add New House Property
    /**
     This method add new house property into database
     
     - Parameter propertyNumber: House number in string.
     - Parameter imageUrl: House image URL/Name in string.
     - Parameter location: House location in string.
     - Parameter address: House address in string.
     - Parameter isFavourite: House is users favourite or not, Bool Value.
     - Parameter isMyHouse: House is added by user, Bool value.
     - Returns: Property Object created and saved into database.
     */
    func insertHouseProperty(propertyNumber: String?, imageUrl: String?, location: String?, address: String?, isFavourite: Bool?, isMyHouse: Bool?, latitudeAndLongitude: String?) -> Property? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entityDescriptor = NSEntityDescription.entity(forEntityName: kProperty,
                                                in: managedContext)!
        let property = NSManagedObject(entity: entityDescriptor,
                                     insertInto: managedContext)
        property.setValue(propertyNumber, forKeyPath: kPropertyNumber)
        property.setValue(imageUrl, forKeyPath: kImageUrl)
        property.setValue(location, forKeyPath: kLocation)
        property.setValue(address, forKeyPath: kAddress)
        property.setValue(isFavourite, forKeyPath: kIsFavourite)
        property.setValue(isMyHouse, forKeyPath: kIsMyHouse)
        property.setValue(latitudeAndLongitude, forKeyPath: kLatitudeAndLongitude)
        do {
            try managedContext.save()
            return property as? Property
        } catch let error as NSError {
            //TODO: Need to do error handling
            return nil
        }
    }
    
    //MARK: Favourite Property
    /**
     This method update existing property into users favourite bucket
     
     - Parameter property: Selected property by user.
     - Parameter isFavourite: Bool value to Enable/Disable favourite.
     */
    func updateFavouriteProperty(property: Property, isFavourite: Bool) {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        property.setValue(isFavourite, forKey: kIsFavourite)
        
        do {
            try context.save()
        } catch let error as NSError  {
            //TODO: Need to do error handling
        } catch {
            
        }
    }

    //MARK: Fetch House data
    /**
     This method loads house property from database
     
     - Parameter propertyNumber: Property number in string.
     - Returns: Array of properties retrived from database, Can be nil to get all values.
     */
    func fetchHouseProperty(propertyNumber: String?) -> [Property]? {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Property>(entityName: kProperty)
        if let propertyNumber = propertyNumber {
            fetchRequest.predicate = NSPredicate(format:"\(kPropertyNumber) = %@", propertyNumber)
        }
        do {
            let propertyList = try managedContext.fetch(fetchRequest)
            return propertyList
        } catch let _ as NSError {
            return nil
        }
    }
}
