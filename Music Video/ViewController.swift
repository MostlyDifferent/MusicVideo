//
//  ViewController.swift
//  Music Video
//
//  Created by Alexander Sramek on 4/17/16.
//  Copyright © 2016 Brother Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    var vVideos = [Video]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //tableView.dataSource = self
        //tableView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.mReachabilityStatusChanged), name: "ReachStatusChanged", object: nil)

        mReachabilityStatusChanged()
        
        let api = APIManager()
        api.mLoadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: mDidLoadData)
//        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json"){
//            (result:String) in
//            print(result)
//        }

        
    }
    
    func mDidLoadData(videos: [Video])
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
        
        tableView.reloadData()
        
    }
    
    func mReachabilityStatusChanged()
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
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return vVideos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("uiTableCell", forIndexPath: indexPath)

        let video = vVideos[indexPath.row]

        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    

}

