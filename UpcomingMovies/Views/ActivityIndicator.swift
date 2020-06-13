//
//  ActivityIndicator.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 12/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
extension UIActivityIndicatorView {
    
    static func getActivityIndicator()->UIActivityIndicatorView{
        let aC = UIActivityIndicatorView(frame:  .zero)
        aC.hidesWhenStopped = true
        aC.style = .large
        aC.color = .white
        let transfrom = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        aC.transform = transfrom
        return aC
    }
}


