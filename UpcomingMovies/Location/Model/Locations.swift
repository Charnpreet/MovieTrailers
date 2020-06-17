//
//  Locations.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 17/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

class Locations : Decodable {
    var iso_3166_1: String
    var english_name: String

    required public init(from jsonObject: AnyObject){
         iso_3166_1 = jsonObject.object(forKey: "iso_3166_1") as! String
         english_name = jsonObject.object(forKey: "english_name") as! String
    }
}

extension Locations : Equatable, Hashable {
    static func == (lhs: Locations , rhs: Locations) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    public func hash(into hasher: inout Hasher) {
            hasher.combine(ObjectIdentifier(self).hashValue)
}


}
