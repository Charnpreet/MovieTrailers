//
//  UpComingMoviesVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
//
class UpComingMoviesVC:  MainVCWithTableView<TableCell, MoviesDetails> {
    var visiblePage: Int = 1
    var totalNoOfPages: Int = 1
    var settingVC : SettingsVC?
    override init(backgroundColorService: BackgroundColor, constant: Constants, nServie: NetworkService, db: DBAcess) {
        super.init(backgroundColorService: backgroundColorService, constant: constant, nServie: nServie, db: db)
        settingVC = SettingsVC(backgroundColorService: backgroundColorService, constant: self.constant, nServie: self.networkServie, db:db)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .clear
        loadMovies(pageNo: 1)
        // Do any additional setup after loading the view.
    }
    private func loadMovies(pageNo: Int){
        loadUpcomingMovies(pageNO: pageNo, completionHandler: {(loaded) in
            if(loaded){
                self.tableView.reloadData()
                self.animateMoviesAlertView()
            }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNaviagtionController()
        guard let settingVC = settingVC else {return}
        if(settingVC.lC.isLocationUpdated()){
            if(itemList.count>0 ){
                itemList.removeAll()
            }
            loadMovies(pageNo: 1)
        }
    }
    
    private func setupNaviagtionController(){
        let settings =  UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(LoadSettingsVC))
        self.navigationItem.rightBarButtonItem = settings
        self.title = "Movies"
    }
    @objc func LoadSettingsVC(){
        guard let settingVC = settingVC else {return}
        self.navigationController?.pushViewController(settingVC, animated:true)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 500
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itm = itemList[indexPath.row]
        let detailVC = DetailVC<MoviesDetails>(backgroundColorService: backgroundColorService, constant: constant, nServie: networkServie, db: db, item: itm)
        LoadSegus(vc: detailVC)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        if indexPath.row == itemList.count - 1 {
            visiblePage += 1
            if(visiblePage  <= totalNoOfPages){
                loadMovies(pageNo: visiblePage)
            }
            else{
                print("no more videos")
            }
        }
    }
    func loadUpcomingMovies(pageNO: Int, completionHandler:@escaping(Bool)->Void){
        let url = Connection.BuildAPIEndPoint(route: Routes.UPCOMING_MOVIES_ROUTE, pageNo: pageNO)
        guard let newUrl = url else {return}
        db.LoadContentFromDB(url: newUrl, completionHandler: { (movies: MovieResponse?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let movies = movies else{return}
                self.itemList.append(contentsOf: movies.results.map({$0}))
                self.totalNoOfPages = movies.total_pages
                completionHandler(true)
                
            }
        })
    }
    
    func animateMoviesAlertView(){
         let usrDefualts = UserDefaults.standard
        let loc = usrDefualts.string(forKey: "location")
        var txt = "now showing movies in \(loc ?? "")"
        if(itemList.count<1){
          txt = "no  new Movies Realsing in \(loc ?? "")"
        }
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
