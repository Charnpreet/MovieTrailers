//
//  UIImageView.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
extension UIImageView {
    
    static func getRoundedImageView(frame: CGRect, cornerRadius: CGFloat)->UIImageView{
        let myImage = UIImageView(frame: frame)
        myImage.layer.cornerRadius = cornerRadius
        myImage.layer.borderWidth = 3
        myImage.layer.shadowColor = UIColor.white.cgColor
        myImage.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        myImage.layer.shadowRadius = 12.0
        myImage.layer.shadowOpacity = 0.7
        myImage.layer.masksToBounds = true
        return myImage
    }
     static func SetupConstraints(ParentView: UIView, childView: UIView){
        ParentView.addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.topAnchor.constraint(equalTo: ParentView.topAnchor, constant: 0.0).isActive = true
        childView.leadingAnchor.constraint(equalTo: ParentView.leadingAnchor, constant: 0.0).isActive = true
        childView.trailingAnchor.constraint(equalTo: ParentView.trailingAnchor, constant: 0.0).isActive = true
        childView.bottomAnchor.constraint(equalTo: ParentView.bottomAnchor, constant: 0.0).isActive = true
    }
}
