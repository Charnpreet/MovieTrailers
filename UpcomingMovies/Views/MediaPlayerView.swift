//
//  MediaPlayerView.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 13/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

extension UIView {
    static func getMediaPlayerView(parentView: UIView, screenHeight: CGFloat, screenWidth: CGFloat)->UIView{
           let view = UIView(frame: .zero)
        view.backgroundColor = .black
            parentView.addSubview(view)
           SetConstraints(childView:view, parentView: parentView, topAnchorConstant: 0, leadingAnchorConstant: 0, trailingAnchorConstant: 0, bottomAnchorConstant: 0)
            setupActivityIndicator(parentView: view)
           let innerView = getInnerViewForMediaControl(parentView: view, screenHeight: screenHeight, screenWidth: screenWidth)
           innerView.backgroundColor = .darkGray
           let button = UIButton.getButton(parentView: view, img: UIImage(named: "cancel")!)
           SetConstraints(childView:button, parentView: view, topAnchorConstant: 20, leadingAnchorConstant: 0, trailingAnchorConstant: -300, bottomAnchorConstant: -700)
           button.addTarget(self, action: #selector(oNcancelButtonClick(viewToCancel:)), for: .touchUpInside)
           guard let imageView = button.imageView else {return view}
           imageView.contentMode = .scaleAspectFit
           return view
           
       }
       @objc private static func oNcancelButtonClick(viewToCancel: UIView){
           viewToCancel.superview?.isHidden = true
       }
       private static func SetConstraints(childView: UIView, parentView: UIView, topAnchorConstant: CGFloat,leadingAnchorConstant:CGFloat, trailingAnchorConstant:CGFloat, bottomAnchorConstant:CGFloat){
           childView.translatesAutoresizingMaskIntoConstraints = false
           childView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: topAnchorConstant).isActive = true
           childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: leadingAnchorConstant).isActive = true
           childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: trailingAnchorConstant).isActive = true
           childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: bottomAnchorConstant).isActive = true
           
       }
       private static func getInnerViewForMediaControl(parentView: UIView, screenHeight: CGFloat, screenWidth: CGFloat)->UIView{
           let bottamConstraint = screenHeight/15
           let topConstraint = screenHeight/1.2
           let innerView = UIView(frame: .zero)
           setupInnerViewMediaControlComponents(parentView:innerView) // adding compnents to inner view
           innerView.layer.cornerRadius = 20
           parentView.addSubview(innerView)
           innerView.translatesAutoresizingMaskIntoConstraints = false
           innerView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: topConstraint).isActive = true
           innerView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 10).isActive = true
           innerView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -10).isActive = true
           innerView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -bottamConstraint).isActive = true
           return innerView
       }
       private static func setupInnerViewMediaControlComponents(parentView:UIView){
           setupSkip15AheadImageView(parentView:parentView)
           setupSkip15BackwordImageView(parentView:parentView)
           setupPlayView(parentView:parentView)
           setupLineView(parentView:parentView)
       }
       private static func setupSkip15AheadImageView(parentView:UIView){
           let imgView = UIImageView.getImageVIew(ParentView: parentView)
           imgView.image = UIImage(named: "farword")
           imgView.contentMode = .scaleAspectFit
           imgView.translatesAutoresizingMaskIntoConstraints = false
           imgView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 40).isActive = true
           imgView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 50).isActive = true
           imgView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -200).isActive = true
           imgView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -20).isActive = true
       }
       private static func setupSkip15BackwordImageView(parentView:UIView){
           let imgView = UIImageView.getImageVIew(ParentView: parentView)
           imgView.image = UIImage(named: "backword")
           imgView.contentMode = .scaleAspectFit
           imgView.translatesAutoresizingMaskIntoConstraints = false
           imgView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 40).isActive = true
           imgView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 200).isActive = true
           imgView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -50).isActive = true
           imgView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -20).isActive = true
       }
       private static func setupPlayView(parentView:UIView){
           let imgView = UIImageView.getImageVIew(ParentView: parentView)
           imgView.image = UIImage(named: "mediaPlay")
           imgView.contentMode = .scaleAspectFit
           imgView.translatesAutoresizingMaskIntoConstraints = false
           imgView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 40).isActive = true
           imgView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 50).isActive = true
           imgView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -50).isActive = true
           imgView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -20).isActive = true
       }
       private static func setupLineView(parentView:UIView){
           let imgView = UIView(frame: .zero)
           parentView.addSubview(imgView)
           imgView.backgroundColor = .gray
           imgView.layer.cornerRadius = 3
           imgView.translatesAutoresizingMaskIntoConstraints = false
           imgView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 16).isActive = true
           imgView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 20).isActive = true
           imgView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -20).isActive = true
           imgView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -60).isActive = true
       }
    
    
    private static func setupActivityIndicator(parentView:UIView){
        let activityIndicator = UIActivityIndicatorView.getActivityIndicator()
        parentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 200).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 100).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -100).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -200).isActive = true
    }
}

