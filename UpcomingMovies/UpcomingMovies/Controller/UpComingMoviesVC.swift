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
                self.animateView()
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
    private func animateView(){
        let usrDefualts = UserDefaults.standard
        let loc = usrDefualts.string(forKey: "location")
        var txt = "Now Showing Movies Releasing in \(loc ?? "")"
        if(itemList.count<1){
            txt = "No New Movies Releasing in \(loc ?? "")"
        }
        animateMoviesAlertView(txt: txt)
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
}
