//
//  ViewController.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 8/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BaseVCForAll: UIViewController {
    let backgroundColorService :BackgroundColor
    let constant : Constants
    var alertView : UIView?
    let networkServie: NetworkService
    let db : DBAcess
    init(backgroundColorService: BackgroundColor, constant: Constants, nServie: NetworkService, db: DBAcess) {
        self.backgroundColorService = backgroundColorService
        self.constant = constant
        self.networkServie = nServie
        self.db = db
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
        networkServie.startMonitoring(completionHandler: {networkAvailble in
            if(!networkAvailble){
                self.alertView?.isHidden = false
            }else{
                self.alertView?.isHidden = true
            }
        })
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = backgroundColorService.getBGClr()
    }
    
    private func initalSetup(){
        setupAlertView()
    }
    private func setupAlertView(){
        let frame = CGRect(x: 0, y: 0, width: constant.IOS_SCREEN_WIDTH, height: constant.IOS_SCREEN_WIDTH)
        alertView = UIView.getAlertView(parentView: self.view, frame: frame, txtclr: backgroundColorService.gettxtClr(), txtToDisplay: "No Network Available")
        alertView?.isHidden = true
    }
}

