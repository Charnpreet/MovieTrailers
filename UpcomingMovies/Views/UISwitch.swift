//
//  UISwitch.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

extension UISwitch{
    
    static func getUISwitch(parentView: UIView, frame: CGRect)->UISwitch{
        let uiSwitch = UISwitch(frame: frame)
        parentView.addSubview(uiSwitch)
        return uiSwitch
    }
}
