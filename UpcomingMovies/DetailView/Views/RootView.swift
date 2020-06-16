//
//  RootView.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 15/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
import YouTubePlayer
class ItmDetailView : UIView, RootViewParentController {
    static let shared = ItmDetailView()
    var controler : UIViewController?
    var imageView : UIImageView?
    var player : YouTubePlayerView?
    var playButton: UIButton?
    var activityIndicator: UIActivityIndicatorView?
    var mediaPlayerView: UIView?
    var mediaPlayer: MediaPlayerView?
    var constant: Constants
    private init(){
        constant = Constants.shared
        super.init(frame: .zero)
        mediaPlayer = MediaPlayerView.shared
        imageView = getLandScapeImageView(parentView: self)
       //
        imageView?.layer.borderColor = UIColor.red.cgColor
        player = loadYouTubePlayer(view: self)
        playButton = setupButton(view: self)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func loadYouTubePlayer(view: UIView)->YouTubePlayerView?{
        let player = YouTubePlayerView(frame: CGRect(x: 0, y: 100, width: constant.IOS_SCREEN_WIDTH, height: constant.IOS_SCREEN_HEIGHT/2))
        player.isHidden = true
        view.addSubview(player)
        return player
    }
    private func setupButton(view: UIView)->UIButton?{
    guard let img = UIImage(named: "play1") else { return nil}
    let button = UIButton.getButton(parentView: view, img: img)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.imageView?.contentMode = .scaleAspectFit
    button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150).isActive = true
    button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150).isActive = true
    button.bottomAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: -100).isActive = true
    button.addTarget(self, action: #selector(onPlayButtonClick), for: .touchUpInside)
    button.isHidden = true
    return button
    }
    
    @objc func onPlayButtonClick(){
        playButton?.isHidden = true
        guard let controler = controler else{ return}
        controler.navigationController?.setNavigationBarHidden(true, animated: true)
        mediaPlayerView?.isHidden = false
        player?.play()
    }
    
    func setParentViewController(_ parentViewController: UIViewController?) {
        guard let parentViewController = parentViewController else {return}
        self.controler = parentViewController
        player?.delegate = controler as? YouTubePlayerDelegate
        mediaPlayer?.delgate = controler as? YouTubePlayerNotifer
        controler?.view.addSubview(self)
        rootViewConstraints(parentView: controler!.view, childView: self)
        mediaPlayerView = mediaPlayer?.getMediaPlayerView(parentView: self, screenHeight: constant.IOS_SCREEN_HEIGHT, screenWidth: constant.IOS_SCREEN_WIDTH)
        mediaPlayerView?.isHidden = true
        
    }

    func rootViewConstraints(parentView: UIView, childView: UIView){
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0).isActive = true
        childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0).isActive = true
        childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -0).isActive = true
        childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -0).isActive = true
        
    }
    func getLandScapeImageView(parentView: UIView)->UIImageView{
        let imageView = UIImageView.getImageVIew(ParentView: parentView)
        parentView.layoutIfNeeded()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -0).isActive = true
        return imageView
    }
}
