//
//  PropertyCollectionViewController.swift
//  SampleHouseProj
//
//  Created by amee on 13/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit


class PropertyCollectionViewController: UIViewController {
    
    @IBOutlet weak var horizontalTabsCollectionView: UICollectionView?
    @IBOutlet weak var propertyCollectionView: UICollectionView?
    @IBOutlet weak var searchBar: UISearchBar?
    private let propertyViewModel: PropertyCollectionViewModel = PropertyCollectionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //For default selection of tab bar to collection tab
        tabBarButtonSelected(sender: UIButton())
        
        //Notification on favorite updated
        NotificationCenter.default.addObserver(self, selector: #selector(recordsUpdated), name: Notification.Name(NOTIFICATION_UPDATE_DATASOURCE), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == kPropertyDetailsSegueIdentifire else {
            return
        }
        let cellViewModelList: [PropertyCollectionViewCellViewModel] = propertyViewModel.getPropertyList(searchText: searchBar?.text ?? "")
        if let viewController: PropertyDetailsViewController = segue.destination as? PropertyDetailsViewController, let indexPath = sender as? IndexPath, !cellViewModelList.isEmpty {
            let cellViewModel: PropertyCollectionViewCellViewModel = cellViewModelList[indexPath.row]
            viewController.property = CoreDataManager.sharedManager.fetchHouseProperty(propertyNumber: cellViewModel.getPropertyNumber())?.first
        }
    }
    
    /**
     This method updates the Datasource when any save operation with Database
     */
    @objc private func recordsUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.propertyViewModel.updateDataSource()
            self?.propertyCollectionView?.reloadData()
        }
    }
}

//MARK: Collection View Data Source Methods
extension PropertyCollectionViewController: UICollectionViewDataSource {
    
    func collectionView( _ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == propertyCollectionView {
            return propertyViewModel.getPropertyList(searchText: searchBar?.text ?? "").count
        } else {
            return kCollectionViewCellIdentifires.count
        }
    }
    
    func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
            var collectionViewCell: UICollectionViewCell
            if collectionView == propertyCollectionView     {
                collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPropertyCollectionViewCellIdentifire, for: indexPath)
                let cellViewModel: PropertyCollectionViewCellViewModel = propertyViewModel.getPropertyList(searchText: searchBar?.text ?? "")[indexPath.row]
                (collectionViewCell as? PropertyCollectionViewCell)?.configureView(cellViewModel: cellViewModel)
            } else {
                collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellIdentifires[indexPath.row], for: indexPath)
            }
            return collectionViewCell
    }
}

//MARK: Collection View Delegate Methods
extension PropertyCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == propertyCollectionView {
            performSegue(withIdentifier: kPropertyDetailsSegueIdentifire, sender: indexPath)
        }
    }
}

//MARK: Tab View Button Actions
extension PropertyCollectionViewController {
    /**
     This function updates status of tab bar, reloads UI
     
     - Parameter sender: Holds UIButton object along with tag value to identify which button it is.
     */
    @IBAction func tabBarButtonSelected(sender: Any?) {
        var selectedTab: SelectedTab = .collection
        if let button: UIButton = sender as? UIButton {
            switch button.tag {
            case 0:
                selectedTab = .collection
            case 1:
                selectedTab = .favourite
            case 2:
                selectedTab = .myHouse
            case 3:
                selectedTab = .duplicate
            case 4:
                selectedTab = .missing
            default:
                break
            }
            propertyViewModel.setSelectedTab(selectedTab: selectedTab)
            DispatchQueue.main.async { [weak self] in
                self?.updateNavigationTitle()
                self?.propertyCollectionView?.reloadData()
            }
        }
    }
    
    /**
     This method updates the Navigation Bar Title
     */
    private func updateNavigationTitle() {
        switch propertyViewModel.currentSelectedTab {
        case .collection:
            self.navigationItem.title = kCollectionViewTitle
        case .favourite:
            self.navigationItem.title = kFavouriteViewTitle
        case .myHouse:
            self.navigationItem.title = kMyHouseViewTitle
        case .duplicate:
            self.navigationItem.title = kDuplicateViewTitle
        case .missing:
            self.navigationItem.title = kMissingViewTitle
        }
    }
}

//MARK: Search
extension PropertyCollectionViewController: UISearchBarDelegate {
    /**
     This method handles search bar visiblity
     */
    @IBAction private func searchBarButtonAction() {
        searchBar?.text = ""
        if searchBar?.isHidden == true {
            searchBar?.becomeFirstResponder()
        } else {
            searchBar?.resignFirstResponder()
            propertyCollectionView?.reloadData()
        }
        searchBar?.isHidden = !(searchBar?.isHidden ?? false)
    }
    
    /**
     This delegate Method handles cancel button action and clear search UI
     */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.isHidden = true
        propertyCollectionView?.reloadData()
    }
    
    /**
     This delegate Method hit get called for each character change
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        propertyCollectionView?.reloadData()
    }

    /**
     This delegate Method returns the keyboard on selection of keyboard Done button
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

