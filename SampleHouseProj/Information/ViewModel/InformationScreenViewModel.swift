//
//  InformationViewModel.swift
//  SampleHouseProj
//
//  Created by amee on 17/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit

class InformationScreenViewModel {
    
    private let informationModel: InformationScreenModel = InformationScreenModel()
    private var informationCellViewModelList: Array<InformationScreenCellViewModel> = []
    
    init() {
        createCellViewModels()
    }
  
    //MARK: Data Source Getter
    /**
     Returns data source for drawing cells
     
     - Returns: array of string.
     */
    func getDataSource() -> Array<InformationScreenCellViewModel> {
        return informationCellViewModelList
    }

    //MARK: Data Source Create
    /**
     This function create list for create cell view model and store into local array
     */
    private func createCellViewModels() {
        for titleString in informationModel.getInformationOptions() {
            let informationCellViewModel: InformationScreenCellViewModel = InformationScreenCellViewModel(titleString: titleString)
            informationCellViewModelList.append(informationCellViewModel)
        }
    }
}
