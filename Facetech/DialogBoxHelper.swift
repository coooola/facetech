//
//  DialogBoxHelper.swift
//  Facetech
//
//  Created by Julia Favrel on 08/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import UIKit

class DialogBoxHelper{
    //
    /// shows an alert dialog box with two messages
    ///
    /// - Parameters:
    ///     - title: title of dialog box seen as main message
    ///     - msg: additional message used to describe context or additional information
    class func alert(view: UIViewController, WithTitle title: String, andMessage msg: String = "") {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(cancelAction)
        view.present(alert, animated: true)
    }
    
    /// shows an alert to inform about an error
    ///
    /// - Parameter error: error we want information about
    class func alert(view: UIViewController, error: NSError) {
        self.alert(view: view, WithTitle: "\(error)", andMessage: "\(error.userInfo)")
    }
    
}
