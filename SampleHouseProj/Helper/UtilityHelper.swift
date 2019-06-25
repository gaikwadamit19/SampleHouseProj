//
//  UtilityHelper.swift
//  SampleHouseProj
//
//  Created by amee on 15/05/19.
//  Copyright © 2019 amee. All rights reserved.
//

import UIKit

//Utility helper helps to access Alert Controller easily from anywhere
class UtilityHelper {
    /**
     This method helps to access Alert Controller easily from anywhere
     
     - Parameter message: Text need to show to user.
     - Parameter viewController: On which AlertView will get shown.
     */
    static func showAlertView(message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: kAlert, message: message, preferredStyle: .alert)
        let alertAction: UIAlertAction = UIAlertAction(title: kAlertButtonTitle, style: .default, handler: nil)
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
