//
//  InformationScreenViewCell.swift
//  SampleHouseProj
//
//  Created by amee on 17/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit


class  InformationScreenCell: UITableViewCell {
    
    @IBOutlet private weak var propertyNumberLabel: UILabel?
    
    /**
     This method configure the view for setting images and texts
     
     - Parameter cellViewModel: view model which is responsible for managing that view.
     */
    func configureView(cellViewModel: InformationScreenCellViewModel) {
        propertyNumberLabel?.text = cellViewModel.getCellTitle()
    }
}
