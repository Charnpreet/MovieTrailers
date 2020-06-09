//
//  NetworkService.swift
//  UpcomingMovies
//
//  Created by CHARNPREET SINGH on 9/6/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Network
class NetworkService {
    
    static let shared = NetworkService()
    var monitor: NWPathMonitor!
    
    private init() {
        
    }
    
    func startMonitoring(completionHandler:@escaping(Bool)->Void) {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if (path.status == .satisfied ){
                
                DispatchQueue.main.async {
                    completionHandler(true)
                }
                
            }
            if(path.status == .unsatisfied){
                DispatchQueue.main.async {
                    completionHandler(false)
                }
            }
        }
        
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
    
}
