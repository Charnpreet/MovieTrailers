//
//  DB.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation

class Connection {
    private static let  IMAGE_URL_BASE_PATH = "https://image.tmdb.org/t/p/w342//"
    private static let  API_BASE_URL = "https://api.themoviedb.org/3/"
    private static let  API_KEY = ""
    private static let API_KEY_PATH = "api_key=\(API_KEY)"
    private static let PAGE = "&page="
    
    static var IMGAE_BASE_URL: String {
        get{
            return IMAGE_URL_BASE_PATH
        }
    }
    static func BuildAPIEndPoint(route: String, pageNo: Int)->URL?{
        let urlString = "\(API_BASE_URL)\(route)\(API_KEY_PATH)\(PAGE)\(pageNo)"
        let url = URL(string: urlString) ?? nil
        return url
    }
    static func BuildVideoAPIEndPoint(route: String, content_Type: String, content_ID: Int) -> URL? {
        let urlString = "\(API_BASE_URL)\(content_Type)\(content_ID)\(route)\(API_KEY_PATH)"
        let url = URL(string: urlString) ?? nil
        return url
    }
}
