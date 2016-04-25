//
//  ViewController.swift
//  Music Video
//
//  Created by Alexander Sramek on 4/17/16.
//  Copyright © 2016 Brother Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    

        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
//        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json"){
//            (result:String) in
//            print(result)
//        }

        
    }
    
    func didLoadData(result:String) {
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
        print(result)
        
        //print(result)
    }

}

