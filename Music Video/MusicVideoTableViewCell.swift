//
//  MusicVideoTableViewCell.swift
//  Music Video
//
//  Created by Alexander Sramek on 5/10/16.
//  Copyright © 2016 Brother Alex. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell
{

        //Whenever the video is set, updates the cell UI.
    var fVideo: Video?
    {
        didSet
        {
            mUpdateCell()
        }
    }
    
    @IBOutlet weak var uiMusicImage: UIImageView!
    @IBOutlet weak var uiRankLabel: UILabel!
    @IBOutlet weak var uiMusicTitleLabel: UILabel!
    
    func mUpdateCell()
    {
        uiMusicTitleLabel.text = fVideo?.fName
        uiRankLabel.text = "\(fVideo!.fRank)"
        //uiMusicImage.image = UIImage(named: "imageNotAvailable")
        
            //If we have image data already for this video...
        if fVideo!.fImageData != nil
        {
                //Just get the existing image data and put it into the UI
            print("Get data from array ...")
            uiMusicImage.image = UIImage(data: fVideo!.fImageData!)
        }
        else
        {
                //Get the image into the video, and put it into the UI image.
            print("Get images in background thread")
            mGetVideoImage(fVideo!, imageView: uiMusicImage)
        }
        
    }
    
    
    func mGetVideoImage(video: Video, imageView: UIImageView)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        {
                //Get the raw image data from the URL
            let data = NSData(contentsOfURL: NSURL(string: video.fImageUrl)!)
            
                //Variable for UI-ready image data
            var image: UIImage?
            
                //If we got actual data...
            if data != nil
            {
                    //Set the video's image data to the data we got.
                video.fImageData = data
                
                    //Set the UI image to processed data
                image = UIImage(data: data!)
            }
            
            dispatch_async(dispatch_get_main_queue())
            {
                    //Set the image in the parameter to the UI-ready image we got (if we got it)
                imageView.image = image
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}
