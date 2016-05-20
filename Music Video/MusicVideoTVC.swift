//
//  MusicVideoTVC.swift
//  Music Video
//
//  Created by Alexander Sramek on 5/7/16.
//  Copyright © 2016 Brother Alex. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {
    
    var fVideos = [Video]()
    
    private struct sStoryboard
    {
        static let fCellReuseIdentifier = "uiTableCell"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.mReachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MusicVideoTVC.mPreferredFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)

            //Run the status checker once to get the initial status
        mReachabilityStatusChanged()

    }
    
    func mPreferredFontChanged()
    {
        print("Preferred font changed")
    }
    
    func mDidLoadData(videos: [Video])
    {
        fVideos = videos
        
        for item in videos
        {
            print("name = \(item.fName)")
        }
        
        for(index, item) in videos.enumerate()
        {
            print("\(index) name = \(item.fName)")
        }
        
        tableView.reloadData()
        
    }
    
    func mReachabilityStatusChanged()
    {
        switch gReachabilityStatus
        {
        case kReachNoAccess :
        //    view.backgroundColor = UIColor.redColor()
            
            dispatch_async(dispatch_get_main_queue())
            {
            
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internets.", preferredStyle: .Alert)
    
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default)
                { action -> () in
                
                    print("Cancel")
                
                }
            
                    //Destructive makes it show up in red
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive)
                { action -> () in
                
                    print("...Followed By Delete")
                
                }
        
                let okAction = UIAlertAction(title: "OK", style: .Default)
                { action -> Void in
                
                    print("Ok")
                
                }
        
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
            
                self.presentViewController(alert, animated: true, completion: nil)
            
            }
         default:
    //        view.backgroundColor = UIColor.greenColor()
            
                //If we have already loaded the videos, don't reload.
                //We might want to do that otherwise on demand, but not just because network status changed.
            if fVideos.count > 0
            {
                print("do not refresh API")
            }
            else
            {
                mRunAPI()
            }
        }
    }
    
    func mRunAPI()
    {
        
        let api = APIManager()
        api.mLoadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: mDidLoadData)
       
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return fVideos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(sStoryboard.fCellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        cell.fVideo = fVideos[indexPath.row]
    
        
        
        return cell
   }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
