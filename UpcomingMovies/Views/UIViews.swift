//
//  NetWorkALertView.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

extension UIView {
    static func getAlertView(parentView: UIView, frame: CGRect, txtclr: UIColor, txtToDisplay: String) -> UIView {
        let alertView = UIView(frame: frame)
        let label = UILabel(frame: frame)
        label.textAlignment = .center
        label.textColor = txtclr
        label.text = txtToDisplay
        alertView.addSubview(label)
        parentView.addSubview(alertView)
        return alertView
    }
    static func getSquareUIView(parentView: UIView ,frame: CGRect)->UIView{
        let myView = UIView(frame: frame)
        myView.backgroundColor = .clear
        myView.layer.cornerRadius = 20.0
        myView.layer.borderWidth = 2
        myView.layer.borderColor = UIColor.gray.cgColor
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        myView.layer.shadowRadius = 12.0
        myView.layer.shadowOpacity = 0.7
        parentView.addSubview(myView)
        ConstraintView.shared.setUpConstraints(ParentView: parentView, childView: myView, topAnchor: 10.0, leadingAnchor: 25.0, trailingAnchor: -25.0, bottomAnchor: -10.0)
        return myView
    }
}


