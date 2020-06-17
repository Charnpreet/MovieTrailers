//
//  SettingsVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class SettingsVC: MainVCWithTableView<SettingsCell, String> {
    private let usrDefualts = UserDefaults.standard
    var uiSWitch : UISwitch?
    override init(backgroundColorService: BackgroundColor, constant: Constants, nServie: NetworkService, db: DBAcess) {
           super.init(backgroundColorService: backgroundColorService, constant: constant, nServie: nServie, db: db)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        uiSWitch = setupUISwitch()
        self.itemList.append("Dark Mode")
         self.itemList.append("Location")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Settings"
        self.navigationController?.navigationBar.largeTitleTextAttributes  = [NSAttributedString.Key.foregroundColor: backgroundColorService.gettxtClr()]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        guard  let uiSWitch = uiSWitch else{return cell}
        if(indexPath.row==0){
          cell.addSubview(uiSWitch)
        }
        if(indexPath.row==1){
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
 
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let lC = LocationVC(backgroundColorService: backgroundColorService, constant: self.constant, nServie: self.networkServie, db: db)
    if(indexPath.row==1){
               LoadSegus(vc: lC)
    }
    }
    private func setupUISwitch()-> UISwitch{
        let uiSWitch =  UISwitch.getUISwitch(parentView: self.view, frame: .zero)
        uiSWitch.center.x = constant.IOS_SCREEN_WIDTH - uiSWitch.frame.width
        uiSWitch.addTarget(self, action: #selector(updateBack), for: .allEvents)
        uiSWitch.isOn = usrDefualts.bool(forKey: "darkMode")
        return uiSWitch
    }
    @objc func updateBack(){
        guard  let uiSWitch = uiSWitch else{return}
        if(uiSWitch.isOn){
            usrDefualts.set(true, forKey: "darkMode")
        }else{
            usrDefualts.set(false, forKey: "darkMode")
        }
        tableView.reloadData()
        viewWillAppear(true)
    }
}
