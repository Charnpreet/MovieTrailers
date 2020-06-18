//
//  LocationVC.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class LocationVC: MainVCWithTableView<LocationCell, Locations>{
    var selectedValue : String?
    var locationChaged = false
    var delegate: LocationUpdated!
    var searchController : UISearchController?
    var filterArray:[Locations] = []
    private let usrDefualts = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        loadLocations(completionHandler: {(loaded) in
            if(loaded){
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let noOfRows = super.tableView(tableView, numberOfRowsInSection: section)
        guard let searchController = searchController else {
            return noOfRows
        }
        if(searchController.searchBar.searchTextField.isEditing){
            return filterArray.count
        }
        return noOfRows
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell =   tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        guard let searchController = searchController else {
            selectedValue = itemList[indexPath.row].iso_3166_1
            saveLocation(value: selectedValue)
            return
        }
        if(searchController.searchBar.searchTextField.isEditing && filterArray.count>0){
            selectedValue = filterArray[indexPath.row].iso_3166_1
            saveLocation(value: selectedValue)
        }else{
            selectedValue = itemList[indexPath.row].iso_3166_1
            saveLocation(value: selectedValue)
        }
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell =   tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationCell = super.tableView(tableView, cellForRowAt: indexPath) as! LocationCell
        if(itemList[indexPath.row].iso_3166_1==selectedValue){
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        guard let searchController = searchController else {
            return cell
        }
        if(searchController.searchBar.searchTextField.isEditing && filterArray.count>0) {
            if(filterArray[indexPath.row].iso_3166_1==selectedValue){
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }
        if(searchController.searchBar.searchTextField.isEditing && filterArray.count>0) {
            cell.item  = filterArray[indexPath.row]
        }
        return cell
    }
    private func saveLocation(value: String?){
        usrDefualts.set(value, forKey: "location")
        locationChaged = true
    }
    
}
extension LocationVC : LocationUpdated{
    func isLocationUpdated() -> Bool {
        let result = locationChaged
        return result
    }
    
    
}
extension LocationVC : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let txt = searchController.searchBar.text else {return}
        filterArray = itemList.filter{
            $0.english_name.contains(txt)
            
        }
        print(txt)
        tableView.reloadData()
    }
}
