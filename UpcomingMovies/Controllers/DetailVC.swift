//
//  DetailVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class DetailVC<T>: BaseVCForAll {
    var item : T!
    var imageView : UIImageView
    var image : UIImage?
    override init(backgroundColorService: BackgroundColor, constant: Constants, nServie: NetworkService, db: DBAcess) {
        imageView = UIImageView.getRoundedImageView(frame: .zero, cornerRadius: 0.0)
        super.init(backgroundColorService: backgroundColorService, constant: constant, nServie: nServie, db: db)
        UIImageView.SetupConstraints(ParentView: self.view, childView: imageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         addChildVC(ParentVC: self ,childVC: BottamVC(backgroundColorService: backgroundColorService, constant: constant, nServie: networkServie, db: db))
        //self.navigationController?.navigationBar.isHidden = true
    }
    private func addChildVC(ParentVC: UIViewController,childVC: UIViewController){
        ParentVC.addChild(childVC)
        ParentVC.view.addSubview(childVC.view)
        childVC.didMove(toParent: ParentVC)
       // 3- Adjust bottomSheet frame and initial position.
       let height = view.frame.height
       let width  = view.frame.width
        childVC.view.frame = CGRect(x: 0, y: ParentVC.view.frame.maxY, width: width, height: height)
        
    }
}
