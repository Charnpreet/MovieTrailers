//
//  MainVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class MainVCWithTableView<U: BaseCEll<T>, T>: BaseVCForAll, UITableViewDataSource, UITableViewDelegate {
    var itemList : [T] = []
    var tableView : UITableView!
    override init(backgroundColorService: BackgroundColor, constant: Constants, nServie: NetworkService, db: DBAcess) {
        super.init(backgroundColorService: backgroundColorService, constant: constant, nServie: nServie, db: db)
        setUpUITable()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUITable(){
        let frame = CGRect(x: 0, y: 0, width: constant.IOS_SCREEN_WIDTH, height: constant.IOS_SCREEN_HEIGHT)
        tableView = UITableView.getUITable(parentView: self.view, frame: frame)
        tableView.register(U.self, forCellReuseIdentifier: "tableCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print( self.navigationController)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! U
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = backgroundColorService.gettxtClr()
        cell.item = itemList[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func LoadSegus(vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
