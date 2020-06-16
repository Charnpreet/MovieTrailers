//
//  MediaPlayerView.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 13/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class MediaPlayerView : UIView {
    var delgate : YouTubePlayerNotifer?
    static var shared = MediaPlayerView()
    private init(){
        super.init(frame: .zero)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func getMediaPlayerView(parentView: UIView, screenHeight: CGFloat, screenWidth: CGFloat)->UIView{
        let view = UIView()
        view.backgroundColor = .black
        parentView.addSubview(view)
        SetConstraints(childView:view, parentView: parentView, topAnchorConstant: 0, leadingAnchorConstant: 0, trailingAnchorConstant: 0, bottomAnchorConstant: 0)
       setupActivityIndicator(parentView: view)
        let button = UIButton.getButton(parentView: view, img: UIImage(named: "cancel")!)
        SetConstraints(childView:button, parentView: view, topAnchorConstant: 15, leadingAnchorConstant: 0, trailingAnchorConstant: screenWidth/1.4, bottomAnchorConstant: screenHeight/1.19)
        setupInnerView(parentView: view, top: button.bottomAnchor, screenHeight: screenHeight, screenWidth: screenWidth)
        button.addTarget(self, action: #selector(oNcancelButtonClick(viewToCancel:)), for: .touchUpInside)
        guard let imageView = button.imageView else {return view}
        imageView.contentMode = .scaleAspectFit
        return view
        
    }
    @objc private  func oNcancelButtonClick(viewToCancel: UIView){
        viewToCancel.superview?.isHidden = true
        delgate?.stopYoutubePlayer()
    }
    private func SetConstraints(childView: UIView, parentView: UIView, topAnchorConstant: CGFloat,leadingAnchorConstant:CGFloat, trailingAnchorConstant:CGFloat, bottomAnchorConstant:CGFloat){
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: topAnchorConstant).isActive = true
        childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: leadingAnchorConstant).isActive = true
        childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -trailingAnchorConstant).isActive = true
        childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -bottomAnchorConstant).isActive = true
        
    }
    private func setupInnerView(parentView: UIView, top: NSLayoutYAxisAnchor, screenHeight: CGFloat, screenWidth: CGFloat){
        let topConstraint = screenHeight/1.5
        let innerView = UIView(frame: .zero)
        innerView.layer.cornerRadius = 20
        innerView.backgroundColor = .darkGray
        parentView.addSubview(innerView)
        innerView.translatesAutoresizingMaskIntoConstraints = false
        innerView.topAnchor.constraint(equalTo: top, constant: topConstraint).isActive = true
        innerView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 10.0).isActive = true
        innerView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -10.0).isActive = true
        innerView.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        setupInnerViewMediaControlComponents(parentView:innerView, screenHeight: screenHeight, screenWidth: screenWidth) // adding compnents to inner view
    }
    private func setupInnerViewMediaControlComponents(parentView:UIView, screenHeight: CGFloat, screenWidth: CGFloat){
         parentView.layoutIfNeeded()
        setupSkip15AheadImageView(parentView:parentView)
        setupSkip15BackwordImageView(parentView:parentView)
        setupPlayView(parentView:parentView)
    }
    private  func setupSkip15AheadImageView(parentView:UIView){
        let imgView = UIImageView.getImageVIew(ParentView: parentView)
        imgView.image = UIImage(named: "farword")
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: parentView.layer.bounds.height/3.5).isActive = true
        imgView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: parentView.layer.bounds.width/7.3).isActive = true
        imgView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -parentView.layer.bounds.width/1.9).isActive = true
        imgView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -parentView.layer.bounds.height/5).isActive = true
    }
    private func setupSkip15BackwordImageView(parentView:UIView){
        let imgView = UIImageView.getImageVIew(ParentView: parentView)
        imgView.image = UIImage(named: "backword")
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: parentView.layer.bounds.height/3.5).isActive = true
        imgView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: parentView.layer.bounds.width/1.9).isActive = true
        imgView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -parentView.layer.bounds.width/7.3).isActive = true
        imgView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -parentView.layer.bounds.height/5).isActive = true
        imgView.layoutIfNeeded()
        //setupLineView(parentView:parentView, nearestBottamElmentTopAnchor: imgView.topAnchor)
    }
    private func setupPlayView(parentView:UIView){
        let imgView = UIImageView.getImageVIew(ParentView: parentView)
        imgView.image = UIImage(named: "mediaPlay")
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: parentView.layer.bounds.height/3.5).isActive = true
        imgView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: parentView.layer.bounds.width/5.5).isActive = true
        imgView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -parentView.layer.bounds.width/5.5).isActive = true
        imgView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -parentView.layer.bounds.height/5).isActive = true
    }
    private func setupLineView(parentView:UIView, nearestBottamElmentTopAnchor: NSLayoutYAxisAnchor){
        let imgView = UIView(frame: .zero)
        parentView.addSubview(imgView)
        imgView.backgroundColor = .gray
        imgView.layer.cornerRadius = 3
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: parentView.layer.bounds.height/10).isActive = true
        imgView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 20).isActive = true
        imgView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -20).isActive = true
        imgView.bottomAnchor.constraint(equalTo: nearestBottamElmentTopAnchor, constant: -parentView.layer.bounds.height/8.5).isActive = true
    }
    
    
    private func setupActivityIndicator(parentView:UIView){
        let activityIndicator = UIActivityIndicatorView.getActivityIndicator()
        parentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        parentView.layoutIfNeeded()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: parentView.topAnchor, constant: parentView.bounds.height/2.5).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 100).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -100).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -parentView.bounds.height/2.5).isActive = true
    }
}

