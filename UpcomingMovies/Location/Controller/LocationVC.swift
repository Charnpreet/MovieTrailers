//
//  LocationVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class LocationVC: MainVCWithTableView<SettingsCell, String> {

    override func viewDidLoad() {
        super.viewDidLoad()
        itemList.append("Locations will be retreived from db")
//
    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = super.tableView(tableView, cellForRowAt: indexPath)
//        return cell
//    }
//override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("000000---------")
//    }
}
