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
    var selectedContry : String?
    var uiSWitch : UISwitch?
    var lC : LocationVC!
    override init(backgroundColorService: BackgroundColor, constant: Constants, nServie: NetworkService, db: DBAcess) {
        super.init(backgroundColorService: backgroundColorService, constant: constant, nServie: nServie, db: db)
        lC = LocationVC(backgroundColorService: backgroundColorService, constant: self.constant, nServie: self.networkServie, db: db)
    }
    //
    //
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        uiSWitch = setupUISwitch()
        self.itemList.append("Dark Mode")
        self.itemList.append("Location")
    }
    //
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Settings"
        self.navigationController?.navigationBar.largeTitleTextAttributes  = [NSAttributedString.Key.foregroundColor: backgroundColorService.gettxtClr()]
        selectedContry = getLoation()
        let lChanged = lC.delegate?.isLocationUpdated()
        guard let locationChanged = lChanged else {return}
        if(locationChanged){
            tableView.reloadData()
        }
    }
    //
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! SettingsCell
        guard  let uiSWitch = uiSWitch else{return cell}
        if(indexPath.row==0){
            cell.addSubview(uiSWitch)
            setupConstraintsForUISwitch(parentView: cell.contentView, uiSwitchView: uiSWitch)
        }
        if(indexPath.row==1){
            cell.accessoryType = .disclosureIndicator
            guard let selectedContry = selectedContry else {return cell}
            cell.subTextLable.text = "\(selectedContry)"
            cell.subTextLable.textColor = backgroundColorService.gettxtClr()
        }
        return cell
    }
    //
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row==1){
            LoadSegus(vc: lC)
        }
    }
    //
    //
    private func setupUISwitch()-> UISwitch{
        let uiSWitch =  UISwitch.getUISwitch(parentView: self.view, frame: .zero)
        uiSWitch.center.x = constant.IOS_SCREEN_WIDTH - uiSWitch.frame.width
        uiSWitch.addTarget(self, action: #selector(updateBack), for: .allEvents)
        uiSWitch.isOn = usrDefualts.bool(forKey: "darkMode")
        return uiSWitch
    }
    //
    //
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
    //
    //
    func setupConstraintsForUISwitch(parentView: UIView, uiSwitchView: UIView){
        let width = (uiSWitch?.layer.bounds.width ?? 51) + 10
        
        uiSwitchView.translatesAutoresizingMaskIntoConstraints = false
        uiSwitchView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 5).isActive = true
        uiSwitchView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: constant.IOS_SCREEN_WIDTH - width).isActive = true
        uiSwitchView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -10).isActive = true
        uiSwitchView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -5).isActive = true
        
        
    }
    //
    //
    private func getLoation()-> String?{
        let location =  usrDefualts.string(forKey: "location")
        return location
    }
    
}
