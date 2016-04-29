//
//  ViewController.swift
//  Music Video
//
//  Created by Alexander Sramek on 4/17/16.
//  Copyright © 2016 Brother Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    var vVideos = [Video]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    

        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
//        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json"){
//            (result:String) in
//            print(result)
//        }

        
    }
    
    func didLoadData(videos: [Video])
    {
        vVideos = videos
        
        for item in videos
        {
            print("name = \(item.vName)")
        }
        
        for(index, item) in videos.enumerate()
        {
            print("\(index) name = \(item.vName)")
        }
        
    }


}

