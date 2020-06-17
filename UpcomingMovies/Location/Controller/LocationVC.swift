//
//  LocationVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class LocationVC: MainVCWithTableView<LocationCell, Locations> {
    var selectedCell : IndexPath?
    var selectedValue : String?
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =   tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedCell = indexPath
        selectedValue = itemList[indexPath.row].iso_3166_1
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell =   tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        guard let selectCell = selectedCell else {return cell}
        
        
        if(selectCell == indexPath){
            cell.accessoryType = .checkmark
            
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
}
