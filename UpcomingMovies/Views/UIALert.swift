//
//  UIALert.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 10/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

extension UIAlertController{
    
    static func getUIAlertController(alertTitle: String, alertMessage: String, alertActionTitle: String)->UIAlertController{
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
}
