//
//  APIManager.swift
//  Music Video
//
//  Created by Alexander Sramek on 4/24/16.
//  Copyright © 2016 Brother Alex. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: (result:String) -> Void) {
        
            //no caching
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
            //get our singleton, with specified configuration
        let session = NSURLSession(configuration: config)
        
            //get the singleton
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
            //task that goes out and gets the url.
            //Starts in a passive state.
        let task = session.dataTaskWithURL(url){
            (data, response, error) -> Void in
            
                //Move it into the main queue
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    completion(result: (error!.localizedDescription))
                } else {
                    completion(result: "NSURLSession successful")
                    print(data)
                        
                }
                
            }
        }
        task.resume()
    }
    
}