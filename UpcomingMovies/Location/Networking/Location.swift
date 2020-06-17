//
//  Location.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 17/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import UIKit

public func LoadLocationsFromDB<T:Decodable>(url: URL, completionHandler:@escaping(T?, Error?)->Void){
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if (error != nil){
            print ("error")
            completionHandler(nil ,error)
        }else{
            do{
                guard let data = data else { return }
                let deocder = JSONDecoder()
                deocder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(movies, nil)
                }
            } catch{
                print(error)
                completionHandler(nil, error)
            }
            
        }
    }
    task.resume()
}
