//
//  PropertyDetailsView.swift
//  SampleHouseProj
//
//  Created by amee on 15/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit
import MapKit

class PropertyDetailsView: UIView {
    
    @IBOutlet private weak var propertyImageView: UIImageView?
    @IBOutlet private weak var favouriteImageView: UIImageView?
    @IBOutlet weak var addToFavouriteButton: UIButton?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var addressLabel: UILabel?
    @IBOutlet weak var mapView: MKMapView?
    
    /**
     This method updates the View for detail page
     
     - Parameter property: Model Object which holds data for view
     */
    func updateView(property: Property?) {
        if property?.isFavourite == true {
            addToFavouriteButton?.setTitle(kRemoveFromFavouriteTitle, for: .normal)
            favouriteImageView?.image = UIImage(named: kFavouriteImageName)
        } else {
            addToFavouriteButton?.setTitle(kAddToFavouriteTitle, for: .normal)
            favouriteImageView?.image = nil
        }
        propertyImageView?.image = UIImage(named: property?.imageUrl ?? "")
        locationLabel?.text = property?.location
        addressLabel?.text = property?.address
        
        let latLongArray: Array = property?.latitudeAndLongitude?.split(separator: ":") ?? []
        if let latitude = latLongArray.first, let longitude = latLongArray.last {
            let annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.title = kSweetHome
            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude) ?? 0, longitude: Double(longitude) ?? 0)
            mapView?.addAnnotation(annotation)
            let viewRegion = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: kDistanceInMeters, longitudinalMeters: kDistanceInMeters)
            mapView?.setRegion(viewRegion, animated: true)
        }
    }
}
