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
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)

        reachabilityStatusChanged()
        
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
    
    func reachabilityStatusChanged()
    {
        switch gReachabilityStatus
        {
            case NOACCESS :
                view.backgroundColor = UIColor.redColor()
                displayLabel.text = "No Internet"
            case WIFI :
                view.backgroundColor = UIColor.greenColor()
                displayLabel.text = "Reachable with WIFI"
            case WWAN :
                view.backgroundColor = UIColor.yellowColor()
                displayLabel.text = "Reachable with Cellular"
            default:
                return
        }
    }

    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

}

