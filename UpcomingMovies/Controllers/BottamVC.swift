//
//  BottamVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class BottamVC: BaseVCForAll {
    
    override init(backgroundColorService: BackgroundColor, constant: Constants, nServie: NetworkService, db: DBAcess) {
        super.init(backgroundColorService: backgroundColorService, constant: constant, nServie: nServie, db: db)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let fullView: CGFloat = UIScreen.main.bounds.height/3
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 80
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.view.backgroundColor = backgroundColorService.getBGClr()
    }
    
    
    private func RoundConrerForView(viewToBeRounded: UIView, radius: CGFloat){
        viewToBeRounded.layer.cornerRadius = radius
        viewToBeRounded.clipsToBounds = true
    }
    func BlurBackgroundView(parentView: UIView){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        bluredView.alpha = 0.2
        parentView.insertSubview(bluredView, at: 0)
    }
    
    private func animateView(viewToBeAnimated: UIView){
        UIView.animate(withDuration: 0.3) { [weak self] in
               let frame = viewToBeAnimated.frame
               let yComponent = self?.partialView
               // force unrap needs to fixed
               // can crash your app
               viewToBeAnimated.frame = CGRect(x: 0, y: yComponent!, width: frame.width, height: frame.height)
           }
    }
    
   private func prePareViewToShow(){
    RoundConrerForView(viewToBeRounded: self.view, radius: 20)
    BlurBackgroundView(parentView: self.view)
    animateView(viewToBeAnimated: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //prePareViewToShow()
    }
}
