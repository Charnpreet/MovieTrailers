//
//  TableView.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 8/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

extension UITableView{
    static func getUITable(parentView: UIView, frame: CGRect)->UITableView{
        let table = UITableView(frame: frame, style: .plain)
        table.backgroundColor = .clear
        parentView.addSubview(table)
        addConstraintsToTable(view:parentView, table : table)
        return table
    }
      private static func addConstraintsToTable(view: UIView, table : UITableView){
//            guard let safeArea = safeArea  else{return}
            table.translatesAutoresizingMaskIntoConstraints = false
            table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
}
