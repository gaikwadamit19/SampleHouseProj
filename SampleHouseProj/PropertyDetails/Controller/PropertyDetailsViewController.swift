//
//  DetailsViewController.swift
//  SampleHouseProj
//
//  Created by amee on 14/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit
import SampleHouseProjNew

class PropertyDetailsViewController: UIViewController {
    
    @IBOutlet weak var propertyDetailsView: PropertyDetailsView?
    
    var property: Property?
    
    override func viewDidLoad() {
        if let property: Property = property {
            DispatchQueue.main.async { [weak self] in
                self?.propertyDetailsView?.updateView(property: property)
            }
        }
    }
    
    //MARK: Favourite
    /**
     This method Enable/Disable favourite and notify to update the datasource
     */
    @IBAction func addToFavouriteAction() {
        guard let property: Property = property else {
            return
        }
        CoreDataManager.sharedManager.updateFavouriteProperty(property: property, isFavourite: !property.isFavourite)
        DispatchQueue.main.async { [weak self] in
            self?.propertyDetailsView?.updateView(property: property)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: NOTIFICATION_UPDATE_DATASOURCE), object: nil)
    }
}

