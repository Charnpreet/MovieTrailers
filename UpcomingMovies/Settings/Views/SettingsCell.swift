//
//  SettingsCell.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit
class SettingsCell : BaseCEll<String>{
    
        override var item: String!{
               didSet{
                let labelText = item
                self.textLabel?.text = labelText
               }
           }
}
