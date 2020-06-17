//
//  DetailVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
import YouTubePlayer
class DetailVC<T>: BaseVCForAll, YouTubePlayerDelegate, YouTubePlayerNotifer {
    var rootView : ItmDetailView?
    var item : T!
    init(backgroundColorService: BackgroundColor, constant: Constants, nServie: NetworkService, db: DBAcess, item: T) {
        self.item = item
        rootView  = ItmDetailView.shared
        super.init(backgroundColorService: backgroundColorService, constant: constant, nServie: nServie, db: db)
        guard let rootView = rootView else {return}
        rootView.setParentViewController(self)
        self.view.addSubview(rootView)
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
        clearNavigationBarBackItemtitle()
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
    
    fileprivate func clearNavigationBarBackItemtitle(){
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    func loadVideos<T>(item : T){
        if(type(of: item)==MoviesDetails.self){
            let anItem = item as! MoviesDetails
            guard let imageView = rootView?.imageView else {return}
            DBAcess.LoadPosterImages(cellImage: imageView, pPath:  anItem.poster_path)
            loadVideoUrl(id: anItem.id)
        }
    }

    func loadVideoUrl(id : Int){
        guard let url = Connection.BuildVideoAPIEndPoint(route: Routes.VIDEO_ROUTE, content_Type: Routes.MOVIE_CONTENT_TYPE, content_ID: id) else {return}
        db.getVideoURL(url: url, completionHandler: {(response:VideoResponse) in
            let result = response.results
            if(result.count>0){
                guard let player = self.rootView?.player else {return}
                player.loadVideoID(result[0].key)
                guard let playButton = self.rootView?.playButton else {return}
                playButton.isHidden = true
            }

        })
    }

    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        guard let mediaPlayerView = rootView?.mediaPlayerView else {return}
        if(videoPlayer.playerState == YouTubePlayerState.Playing){
            mediaPlayerView.isHidden = true
            mediaPlayerView.removeFromSuperview()
        }
        if(videoPlayer.playerState == YouTubePlayerState.Unstarted){

          let alert = UIAlertController.getUIAlertController(alertTitle: "Alert", alertMessage: "Unable to load Video ", alertActionTitle: "Ok")
            self.present(alert, animated: true, completion:{() in
                guard let playButton = self.rootView?.playButton else {return}
                playButton.isHidden = true
                mediaPlayerView.isHidden = true
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            })
        }
        if(videoPlayer.playerState == YouTubePlayerState.Paused || videoPlayer.playerState == YouTubePlayerState.Ended){
            navigationController?.setNavigationBarHidden(false, animated: true)
            guard let playButton = self.rootView?.playButton else {return}
            playButton.isHidden = false
        }
    }

    func playerReady(_ videoPlayer: YouTubePlayerView) {
        if(videoPlayer.ready){
            guard let playButton = self.rootView?.playButton else {return}
            playButton.isHidden = false
        }
    }
    @objc func onPlayButtonClick(){
        guard let playButton = self.rootView?.playButton else {return}
        playButton.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
         guard let mediaPlayerView = rootView?.mediaPlayerView else {return}
        mediaPlayerView.isHidden = false
        guard let player = self.rootView?.player else {return}
        player.play()
    }
    
    func stopYoutubePlayer() {
         guard let player = self.rootView?.player else {return}
         player.stop()
         player.isHidden = true
         navigationController?.setNavigationBarHidden(false, animated: true)
         guard let playButton = self.rootView?.playButton else {return}
         playButton.isHidden = false
     }
}
