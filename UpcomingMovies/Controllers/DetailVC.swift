//
//  DetailVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
import YouTubePlayer
class DetailVC<T>: BaseVCForAll, YouTubePlayerDelegate {
    var item : T!
    var imageView : UIImageView?
    var image : UIImage?
    var player : YouTubePlayerView?
    var playButton: UIButton?
    var activityIndicator: UIActivityIndicatorView?
    var MediaPlayerView: UIView?
    init(backgroundColorService: BackgroundColor, constant: Constants, nServie: NetworkService, db: DBAcess, item: T, UIImage: UIImage?) {
        self.item = item
        self.image = UIImage
        super.init(backgroundColorService: backgroundColorService, constant: constant, nServie: nServie, db: db)
        imageView = UIImageView.getRoundedImageView(ParentView: self.view, frame: .zero, cornerRadius: 20, topAnchor: 0.0, leadingAnchor: 0.0, trailingAnchor: 0.0, bottomAnchor: 0.0)
         MediaPlayerView = UIView.getMediaPlayerView(parentView: self.view, screenHeight: constant.IOS_SCREEN_HEIGHT, screenWidth: constant.IOS_SCREEN_WIDTH)
        MediaPlayerView?.isHidden = true
        player = loadYouTubePlayer(view: self.view)
        guard let player = player else {return}
        playButton = setupButton(view: self.view)
        player.delegate = self
        loadVideos(item : item)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ClearNavigationBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    fileprivate func ClearNavigationBar(){
        let navBarImg = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(navBarImg, for: .default)
        self.navigationController?.navigationBar.shadowImage = navBarImg
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func loadVideos<T>(item : T){
        if(type(of: item)==MoviesDetails.self){
            let anItem = item as! MoviesDetails
            DBAcess.LoadPosterImages(cellImage: imageView!, pPath:  anItem.poster_path)
            loadVideoUrl(id: anItem.id)
        }
    }
    func loadYouTubePlayer(view: UIView)->YouTubePlayerView?{
        let player = YouTubePlayerView(frame: CGRect(x: 0, y: 100, width: constant.IOS_SCREEN_WIDTH, height: constant.IOS_SCREEN_HEIGHT/2))
            player.isHidden = true
        view.addSubview(player)
        return player
    }
    
    func loadVideoUrl(id : Int){
        guard let url = Connection.BuildVideoAPIEndPoint(route: Routes.VIDEO_ROUTE, content_Type: Routes.MOVIE_CONTENT_TYPE, content_ID: id) else {return}
        db.getVideoURL(url: url, completionHandler: {(response:VideoResponse) in
            let result = response.results
            if(result.count>0){
                self.player?.loadVideoID(result[0].key)
                //self.playButton?.isHidden = true
            }
            
        })
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
        if(videoPlayer.playerState == YouTubePlayerState.Playing){
            MediaPlayerView?.isHidden = true
            MediaPlayerView?.removeFromSuperview()
        }

        if(videoPlayer.playerState == YouTubePlayerState.Unstarted){

          let alert = UIAlertController.getUIAlertController(alertTitle: "Alert", alertMessage: "Unable to load Video ", alertActionTitle: "Ok")
            self.present(alert, animated: true, completion:{() in
                self.playButton?.isHidden = true
                self.MediaPlayerView?.isHidden = true
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            })
        }
        if(videoPlayer.playerState == YouTubePlayerState.Paused || videoPlayer.playerState == YouTubePlayerState.Ended){
            navigationController?.setNavigationBarHidden(false, animated: true)
            playButton?.isHidden = false
        }
    }
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        if(videoPlayer.ready){
            playButton?.isHidden = false
        }
    }
    @objc func onPlayButtonClick(){
        playButton?.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        MediaPlayerView?.isHidden = false
        self.player?.play()
    }
    private func setupButton(view: UIView)->UIButton?{
        guard let img = UIImage(named: "play1") else { return nil}
        let button = UIButton.getUIButton(parentView: view, img: img, topAnchor: constant.IOS_SCREEN_HEIGHT/2, leadingAnchor: constant.IOS_SCREEN_WIDTH/5, trailingAnchor: -constant.IOS_SCREEN_WIDTH/4, bottomAnchor:  -constant.IOS_SCREEN_HEIGHT/2.5)
        button.addTarget(self, action: #selector(onPlayButtonClick), for: .touchUpInside)
        button.isHidden = true
        return button
    }
}
