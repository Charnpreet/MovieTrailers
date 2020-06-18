//
//  SettingsCell.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class SettingsCell : BaseCEll<String>{
    var subTextLable : UILabel = UILabel(frame: .zero)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: .subtitle, reuseIdentifier: "tableCell")
        guard let label = self.textLabel else {return}
        self.addSubview(subTextLable)
        subTextLable.translatesAutoresizingMaskIntoConstraints = false
        subTextLable.topAnchor.constraint(equalTo: label.topAnchor, constant: 1).isActive = true
        subTextLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:    self.layer.bounds.width/1.5).isActive = true
        subTextLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.layer.bounds.width/8.5).isActive = true
        subTextLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
        subTextLable.textAlignment = .right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        override var item: String!{
               didSet{
                let labelText = item
                self.textLabel?.text = labelText
               }
           }
    
    
}
