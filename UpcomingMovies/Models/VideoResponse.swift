//
//  VideoResponse.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 11/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

struct VideoResponse: Decodable {
    var id : Int
    var results : [VideoDetails]
}

class VideoDetails: Decodable{
    var id          :String
    var iso_639_1   :String
    var iso_3166_1  :String
    var key         :String
    var name        :String
    var site        :String
    var size        :Double
    var type        :String
    
    required public init(from jsonObject: AnyObject){
        id  = jsonObject.object(forKey: "id") as! String
        iso_639_1  = jsonObject.object(forKey: "iso_639_1") as! String
        iso_3166_1  = jsonObject.object(forKey: "iso_3166_1") as! String
        key  = jsonObject.object(forKey: "key") as! String
        name  = jsonObject.object(forKey: "name") as! String
        site  = jsonObject.object(forKey: "site") as! String
        size  = jsonObject.object(forKey: "size") as! Double
        type  = jsonObject.object(forKey: "itype") as! String
    }
}
