//
//  LocationVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class LocationVC: MainVCWithTableView<LocationCell, Locations> {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocations(completionHandler: {(loaded) in
            if(loaded){
                self.tableView.reloadData()
            }
        })
    }
    
    func loadLocations(completionHandler:@escaping(Bool)->Void){
        let url = Connection.BuildLocationAPIEndPoint(route: Routes.LOCATION)
        guard let newUrl = url else {return}
        db.LoadContentFromDB(url: newUrl, completionHandler: { (locations: [Locations]?, err) in
            if let err = err {
                print(err)
                completionHandler(false)
            } else{
                guard let locations = locations else{return}
                self.itemList.append(contentsOf: locations.map({$0}))
                completionHandler(true)
                
            }
        })
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell =   tableView.cellForRow(at: indexPath)
//        cell?.accessoryType = .checkmark
//    }
}
