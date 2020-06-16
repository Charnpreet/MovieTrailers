//
//  UILabel.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 11/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func getUILabel(parentView: UIView)->UILabel{
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        parentView.addSubview(label)
        return label
    }
}
