//
//  APIManager.swift
//  Music Video
//
//  Created by Alexander Sramek on 4/24/16.
//  Copyright © 2016 Brother Alex. All rights reserved.
//

import Foundation

class APIManager {
    
        //Completion takes an argument of [Video] and returns void
    func loadData(urlString:String, completion: [Video] -> Void) {
        
            //no caching
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
            //get our singleton, with specified configuration
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
            //task that goes out and gets the url.
            //Starts in a passive state.
        let task = session.dataTaskWithURL(url)
        {(data, response, error) -> Void in
            
                //Move it into the main queue
            if error != nil
            {
                print(error!.localizedDescription)
            }
            else
            {
                //JSON Serialization
                
                do
                {
                        //If it executed properly such that the as? was able to get a String:AnyObject
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                            as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray
                    {
                        
                        var videos = [Video]()
                        for entry in entries
                        {
                            let entry = Video(data: entry as! JSONDictionary)
                            videos.append(entry)
                        }
                        
                        let i = videos.count
                        print("iTunesApiManager - total count --> \(i)")
                        print(" ")
                        
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            //Dispatch this block to a concurrent queue
                        dispatch_async(dispatch_get_global_queue(priority, 0))
                        {
                            dispatch_async(dispatch_get_main_queue())
                            {
                                completion(videos)
                            }
                        }
                    }
                }
                    //Catch any problems in JSONObjectWithData()
                catch
                {
                    print("error in NSJSONSerialization")
                }
                
            }//if error != nil else
                
        } //End of task block definition
        
            //Actually make the task happen.
        task.resume()
    }
    
}