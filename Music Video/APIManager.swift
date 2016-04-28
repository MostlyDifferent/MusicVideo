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
        
   //        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
            //task that goes out and gets the url.
            //Starts in a passive state.
        let task = session.dataTaskWithURL(url)
        {(data, response, error) -> Void in
            
                //Move it into the main queue
            if error != nil
            {
                dispatch_async(dispatch_get_main_queue())
                {
                        completion(result: (error!.localizedDescription))
                }
                
            }
            else
            {
                //JSON Serialization
                //print(data)
                
                do
                {
                        //If it executed properly such that the as? was able to get a String:AnyObject
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        as? JSONDictionary
                    {
                        
                        print(json)
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            //Dispatch this block to a concurrent queue
                        dispatch_async(dispatch_get_global_queue(priority, 0))
                        {
                            dispatch_async(dispatch_get_main_queue())
                            {
                                completion(result: "JSONSerialization Successful")
                            }
                        }
                    }
                }
                    //Catch any problems in JSONObjectWithData()
                catch
                {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(result: "error in NSJSONSerialization")
                    }
                }
                
            }//if error != nil else
                
        } //End of task block definition
        
            //Actually make the task happen.
        task.resume()
    }
    
}