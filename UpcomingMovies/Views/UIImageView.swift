//
//  UIImageView.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
extension UIImageView {
    
    static func getRoundedImageView(ParentView: UIView, frame: CGRect, cornerRadius: CGFloat, topAnchor: CGFloat,leadingAnchor: CGFloat,trailingAnchor: CGFloat,bottomAnchor: CGFloat)->UIImageView{
        let myImage = UIImageView(frame: frame)
        myImage.layer.cornerRadius = cornerRadius
        myImage.layer.borderWidth = 3
        myImage.layer.borderColor = UIColor.clear.cgColor
        myImage.layer.shadowColor = UIColor.white.cgColor
        myImage.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        myImage.layer.shadowRadius = 12.0
        myImage.layer.shadowOpacity = 0.7
        myImage.layer.masksToBounds = true
        myImage.contentMode = .scaleAspectFill
        ParentView.addSubview(myImage)
        ConstraintView.shared.setUpConstraints(ParentView: ParentView, childView: myImage, topAnchor:topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor)
        return myImage
    }
    static func getImageVIew(ParentView: UIView)->UIImageView{
        let myImage = UIImageView(frame: .zero)
             ParentView.addSubview(myImage)
        return myImage
    }

}
