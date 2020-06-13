//
//  UIButton.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 10/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

extension UIButton {
    
    static func getUIButton (parentView: UIView, img: UIImage, topAnchor: CGFloat,leadingAnchor: CGFloat,trailingAnchor: CGFloat,bottomAnchor: CGFloat)->UIButton{
        let playButton = UIButton(frame: .zero)
        playButton.backgroundColor = .clear
        playButton.setImage( img, for: .normal)
        //playButton.isUserInteractionEnabled = false
         parentView.addSubview(playButton)
        ConstraintView.shared.setUpConstraints(ParentView: parentView, childView: playButton, topAnchor: topAnchor,leadingAnchor: leadingAnchor,trailingAnchor: trailingAnchor,bottomAnchor: bottomAnchor)
        return playButton
    }
    static func getButton(parentView: UIView, img: UIImage)->UIButton{
        let playButton = UIButton(frame: .zero)
         playButton.setImage( img, for: .normal)
        parentView.addSubview(playButton)
        return playButton
    }
    
}
