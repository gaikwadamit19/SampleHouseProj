//
//  Constants.swift
//  SampleHouseProj
//
//  Created by amee on 14/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

let NOTIFICATION_UPDATE_DATASOURCE = "UPDATE_DATASOURCE"

//MARK: Core Data
let kProperty: String = "Property"
let kPropertyNumber: String = "propertyNumber"
let kImageUrl: String = "imageUrl"
let kLocation: String = "location"
let kAddress: String = "address"
let kIsFavourite: String = "isFavourite"
let kIsMyHouse: String = "isMyHouse"
let kLatitudeAndLongitude: String = "latitudeAndLongitude"


//MARK: PropertyCollectionViewController
let kPropertyDetailsSegueIdentifire: String = "detailScreenIdentifire"
let kCollectionViewCellIdentifires = ["CollectionTabCellIdentifire", "FavouriteTabCellIdentifire", "MyHouseTabCellIdentifire", "DuplicateTabCellIdentifire", "MissingTabCellIdentifire"]
let kPropertyCollectionViewCellIdentifire: String = "kPropertyCollectionViewCellIdentifire"


//Mark: PropertyCollectionViewCell
let kHomeImageName: String = "home"
let kMyHouseImageName: String = "myHouse"

//MARK: PropertyDetailsViewController
let kFavouriteImageName = "favourite"
let kAddToFavouriteTitle = "Add to Favourite"
let kRemoveFromFavouriteTitle = "Remove From Favourite"

//MARK: Navigation Titles
let kCollectionViewTitle: String = "Collection"
let kFavouriteViewTitle: String = "Favourite"
let kMyHouseViewTitle: String = "MyHouse"
let kDuplicateViewTitle: String = "Duplicate"
let kMissingViewTitle: String = "Missing"

//MARK: Alert Utility
let kAlert: String = "Alert"
let kAlertButtonTitle: String = "OK"

//MARK: ALert Messages
let kHouseAddedSuccessMessage: String = "Cheers!! House Added Successfully."
let kHouseAddedFailedMessage: String = "Sorry!! Unable to add your house for now, Please try again later."
let kNoLocationDetailsAvailable: String = "Sorry!! Unable get your location now, Please try again later."
let kPleaseSelectyourLocationFirst: String = "Please select the location first."

//MARK: Dummy Values
let propertyDummyDataArray: Array = ["99","98","97","96","95","94","93",]
let locationDummyDataArray: Array = ["Hotel le Meridien", "Hotel le Margori", "Hotel le Mexico", "Hotel le Pixar", "Hotel le Peman", "Hotel le Arab", "Hotel le Momento"]
let addressDummyDataArray: Array = ["Kleine Houtweg 41, Haarlem", "Kleine Houtweg 41, Monaco", "Kleine Houtweg 41, Breva", "Kleine Houtweg 41, Monare", "Kleine Houtweg 41, Chosky", "Kleine Houtweg 41, Monara", "Kleine Houtweg 41, Rampa"]
let lattitudesAndLongitudeDummyDataArray: [String] = ["52.370216: 4.895168", "53.331028: 6.924460", "50.851368: 5.690973", "52.518536: 5.471422", "52.371807: 4.896029","52.785805: 6.897585", "51.687897: 5.057482"]

//MARK: Map View Message
let kSweetHome: String = "Sweet Home"
let kDistanceInMeters: Double = 400

//MARK: Infromation View Controller
let informationScreenDataArray: Array = ["About Us","Contact Us", "Help"]
let kInformationTableViewCellIdentifire: String = "informationTableViewCellIdentifire"
