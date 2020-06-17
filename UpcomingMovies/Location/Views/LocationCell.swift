//
//  LocationCell.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 17/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

class LocationCell : BaseCEll<Locations>{
    
        override var item: Locations!{
               didSet{
                let labelText = item.english_name
                self.textLabel?.text = labelText
               }
           }
}
