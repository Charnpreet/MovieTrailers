//
//  DBAcess.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import UIKit
class DBAcess{
    static let shared = DBAcess()
    private init(){}
    public func LoadContentFromDB<T:Decodable>(url: URL, completionHandler:@escaping(T?, Error?)->Void){
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
    
    private static func downloadImage(from url: URL ,completionHandler:@escaping(_ img :UIImage)->Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                print (error.debugDescription)
            }else{
                guard let data = data else { return }
                DispatchQueue.main.async {
                    guard  let image = UIImage(data: data) else{
                        return completionHandler(UIImage(named: "img1")!)
                    }
                    completionHandler(image)
                }
                
            }
        }
        
        task.resume()
    }
    
    
    static func LoadPosterImages(textLabel: UILabel, cellImage : UIImageView, pPath: String?, text : String){
        guard let posterPath = pPath else {
            textLabel.text = text
            return
            
        }
        let urlString = "\(Connection.IMGAE_BASE_URL)\(posterPath)"
        
        guard let url = URL(string: urlString ) else {
            textLabel.text = text
            return
            
        }
        downloadImage(from: url, completionHandler: {(img) in
            cellImage.image = img
        })
        
    }
}
