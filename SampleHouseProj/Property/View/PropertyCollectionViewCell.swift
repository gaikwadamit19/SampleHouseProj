//
//  PropertyCollectionViewCell.swift
//  SampleHouseProj
//
//  Created by amee on 15/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit

class PropertyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var propertyImageView: UIImageView?
    @IBOutlet private weak var propertyNumberLabel: UILabel?
    @IBOutlet private weak var locationLabel: UILabel?
    @IBOutlet private weak var addressLabel: UILabel?
    @IBOutlet private weak var favouriteImageView: UIImageView?    
    @IBOutlet private weak var myHouseIdentityImageView: UIImageView?
    
    /**
     This method configure the view for setting images and texts
     
     - Parameter cellViewModel: view model which is responsible for managing that view.
     */
    func configureView(cellViewModel: PropertyCollectionViewCellViewModel) {
        //Provided support to local images only, directly assigning image with string
        propertyImageView?.image = UIImage(named: cellViewModel.getPropertyImageUrl() ?? kHomeImageName)
        propertyNumberLabel?.text = cellViewModel.getPropertyNumber()
        locationLabel?.text = cellViewModel.getLocation()
        addressLabel?.text = cellViewModel.getAddress()
        
        favouriteImageView?.image = (cellViewModel.getIsFavourite() == true) ? UIImage(named: kFavouriteImageName) : nil
        myHouseIdentityImageView?.image = (cellViewModel.getIsMyHouse() == true) ? UIImage(named: kMyHouseImageName) : nil

        //Used from POD Library
        propertyImageView?.circleImageView(borderColor: UIColor.white, borderWidth: 2.0)
    }
}

