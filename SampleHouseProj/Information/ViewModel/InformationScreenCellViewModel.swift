//
//  InformationCellViewModel.swift
//  SampleHouseProj
//
//  Created by amee on 17/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit

class InformationScreenCellViewModel {
    
    private var titleString: String
    
    init(titleString: String) {
        self.titleString = titleString
    }
    
    //MARK: Getters property
    /**
     This method provides title string for cell view model
     
     - Returns: String value for title
     */
    func getCellTitle() -> String {
        return titleString
    }
}
