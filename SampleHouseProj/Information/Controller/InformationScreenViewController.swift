//
//  InformationScreenViewController.swift
//  SampleHouseProj
//
//  Created by amee on 17/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit

class InformationScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    private let informationViewModel: InformationScreenViewModel = InformationScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: TableViewDatasource
extension InformationScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationScreenDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let informationViewCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: kInformationTableViewCellIdentifire, for: indexPath)
        (informationViewCell as? InformationScreenCell)?.configureView(cellViewModel: informationViewModel.getDataSource()[indexPath.row])
        return informationViewCell
    }
}

//MARK: TableViewDelegate
extension InformationScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
