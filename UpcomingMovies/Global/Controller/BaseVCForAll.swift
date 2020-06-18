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
        networkServie.startMonitoring(completionHandler: {networkAvailble in
            if(!networkAvailble){
                self.animateMoviesAlertView(txt: "no network avilable")
            }
        })
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = backgroundColorService.getBGClr()
    }
    
    func animateMoviesAlertView(txt: String){
        let moviesAlertView = UIView.getAlertView(parentView: self.view, frame: .zero, txtclr: backgroundColorService.gettxtClr(), txtToDisplay: txt)
        moviesAlertView.translatesAutoresizingMaskIntoConstraints = false
        moviesAlertView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        moviesAlertView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 1).isActive = true
        moviesAlertView.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor, constant: -1).isActive = true
        moviesAlertView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        moviesAlertView.backgroundColor = .red
        self.view.bringSubviewToFront(moviesAlertView)
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveLinear, animations: {
            moviesAlertView.center.y += 100
        }, completion:{
            _ in UIView.animate(withDuration: 0.6, delay: 2.6, options: .curveEaseInOut, animations: {
                moviesAlertView.center.y -= 100
            }, completion: { _ in
                moviesAlertView.removeFromSuperview()
            })
        })
    }
}

