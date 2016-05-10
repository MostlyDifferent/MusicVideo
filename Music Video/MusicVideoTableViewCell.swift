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
        uiMusicImage.image = UIImage(named: "imageNotAvailable")
    }
}
