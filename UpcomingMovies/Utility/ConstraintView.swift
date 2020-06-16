//
//  ConstraintView.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 11/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class ConstraintView {
    static var shared = ConstraintView()
    init() {}
func setUpConstraints(ParentView: UIView, childView: UIView, topAnchor: CGFloat,leadingAnchor: CGFloat,trailingAnchor: CGFloat,bottomAnchor: CGFloat){
     childView.translatesAutoresizingMaskIntoConstraints = false
     childView.topAnchor.constraint(equalTo: ParentView.topAnchor, constant: topAnchor).isActive = true
     childView.leadingAnchor.constraint(equalTo: ParentView.leadingAnchor, constant: leadingAnchor).isActive = true
     childView.trailingAnchor.constraint(equalTo: ParentView.trailingAnchor, constant: trailingAnchor).isActive = true
     childView.bottomAnchor.constraint(equalTo: ParentView.bottomAnchor, constant: bottomAnchor).isActive = true
     }
}
