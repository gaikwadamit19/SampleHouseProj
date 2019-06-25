//
//  AddYourHouseViewController.swift
//  SampleHouseProj
//
//  Created by amee on 15/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit
import MapKit


class AddHouseViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView?
    @IBOutlet weak var addYourHouseButton: UIButton?
    var locationManager: CLLocationManager?
    var addHouseViewModel: AddHouseViewModel = AddHouseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startMonitoringSignificantLocationChanges()
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap(gestureReconizer:)))
        mapView?.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    /**
     This method handles user selection action for Add Your House button,
     Once user select it, it collect required information and create new property into database
     */
    @IBAction private func addNewHousePropertButtonAction() {
        guard let allAnnotations = mapView?.annotations, !allAnnotations.isEmpty else {
            UtilityHelper.showAlertView(message: kPleaseSelectyourLocationFirst, viewController: self)
            return
        }
        
        guard let locationCordinate: CLLocationCoordinate2D = allAnnotations.first?.coordinate else {
            UtilityHelper.showAlertView(message: kNoLocationDetailsAvailable, viewController: self)
            return
        }
        
        let location: CLLocation = CLLocation(latitude: locationCordinate.latitude, longitude: locationCordinate.longitude)
        addHouseViewModel.addUsersNewHouse(location: location) {
            (status, message) in
            if status == true {
                UtilityHelper.showAlertView(message: message, viewController: self)
                NotificationCenter.default.post(name: Notification.Name(rawValue: NOTIFICATION_UPDATE_DATASOURCE), object: nil)
            } else {
                UtilityHelper.showAlertView(message: message, viewController: self)
            }
        }
    }
}

//MARK: Authntication Handling
extension AddHouseViewController {
    /**
     This method verifies if user is authenticated or not,
     if not then it again request for authorization
     */
    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView?.showsUserLocation = true
        } else {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
}

//MARK: Tap Gesture Handler
extension AddHouseViewController {
    /**
     This method handle tap gesture for map view
     
     - Parameter gestureReconizer: Holds information for tapped location.
     */
    @objc private func handleTap(gestureReconizer: UITapGestureRecognizer) {
        if let allAnnotations = mapView?.annotations, !allAnnotations.isEmpty {
            mapView?.removeAnnotations(allAnnotations)
        }
        let location = gestureReconizer.location(in: mapView)
        if let coordinate = mapView?.convert(location,toCoordinateFrom: mapView) {
            // Add annotation:
            let annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView?.addAnnotation(annotation)
        }
    }
}

//MARK: CLLocation Manager Delegate
extension AddHouseViewController: CLLocationManagerDelegate {
    /**
     This method is delegate method for location manager which get called when user location get detected
     
     - Parameter manager: Location manager which provides all location rlated information.
     - Parameter locations: Contains lattitude and longuttude.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView?.setRegion(region, animated: true)
        }
    }
}
