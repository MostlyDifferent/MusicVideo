//
//  MusicVideo.swift
//  Music Video
//
//  Created by Alexander Sramek on 4/27/16.
//  Copyright © 2016 Brother Alex. All rights reserved.
//

import Foundation

class Video{
    
    var fRank = 0
    
    private var _fName:String
    private var _fRights:String
    private var _fPrice:String
    private var _fImageUrl:String
    private var _fArtist:String
    private var _fVideoUrl:String
    private var _fImid:String
    private var _fGenre:String
    private var _fLinkToiTunes:String
    private var _fReleaseDate:String
    
    
    var fImageData:NSData?
    
    
        //Getters
    
    var fName: String {
        return _fName
    }
    
    var fRights: String {
        return _fRights
    }
    
    var fPrice: String {
        return _fPrice
    }
    
    var fImageUrl: String{
        return _fImageUrl
    }
    
    var fArtist: String {
        return _fArtist
    }
    
    var fVideoUrl: String{
        return _fVideoUrl
    }
    
    var fImid: String {
        return _fImid
    }
    
    var fGenre: String {
        return _fGenre
    }
    
    var fLinkToiTunes: String {
        return _fLinkToiTunes
    }
    
    var fReleaseDate: String {
        return _fReleaseDate
    }
    
    
    
    
    
    
    
    
    init(data: JSONDictionary)
    {
        
            //If we don't init all properties we get an error message
            //Return from initializer without initializing all stored properties
        
            //video name
        
        if let name = data["im:name"] as? JSONDictionary,
            nameLabel = name["label"] as? String
        {
            _fName = nameLabel
        }
        else
        {
            _fName = ""
        }
        
            //Rights
        
        if let rights = data["rights"] as? JSONDictionary,
            rightsLabel = rights["label"] as? String
        {
            _fRights = rightsLabel
        }
        else
        {
            _fRights = ""
        }
        
        
            //Price
            //Using the label. Also available are attributes with a number and a currency.
        if let price = data["im:price"] as? JSONDictionary,
            priceLabel = price["label"] as? String
        {
            _fPrice = priceLabel
        }
        else
        {
            _fPrice = ""
        }
        
        
        
            //video image url
        
        if let img = data["im:image"] as? JSONArray,
            imageAt2 = img[2] as? JSONDictionary,
            imageURL = imageAt2["label"] as? String
        {
            _fImageUrl = imageURL.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }
        else
        {
            _fImageUrl = ""
        }
        
        
            //Artist
        
        if let artist = data["im:artist"] as? JSONDictionary,
            artistLabel = artist["label"] as? String
        {
            _fArtist = artistLabel
        }
        else
        {
            _fArtist = ""
        }
        
        
            //Video URL
        
        if let video = data["link"] as? JSONArray,
            videoAt1 = video[1] as? JSONDictionary,
            videoAttributes = videoAt1["attributes"] as? JSONDictionary,
            videoURL = videoAttributes["href"] as? String
        {
            _fVideoUrl = videoURL
        }
        else
        {
            _fVideoUrl = ""
        }
        
        
            //Imid
        if let vidId = data["id"] as? JSONDictionary,
            idAttributes = vidId["attributes"] as? JSONDictionary,
            imid = idAttributes["im:id"] as? String
        {
            _fImid = imid
        }
        else
        {
            _fImid = ""
        }
        
        
            //Genre
            //Class says to use "term". There's also a "label".
        if let categ = data["category"] as? JSONDictionary,
            catAttributes = categ["attributes"] as? JSONDictionary,
            catTerm = catAttributes["term"] as? String
        {
            _fGenre = catTerm
        }
        else
        {
            _fGenre = ""
        }
        
            //Link to iTunes
            // we don't go for the one in the "link" field, apparently
        if let linkId = data["id"] as? JSONDictionary,
            linkLabel = linkId["label"] as? String
        {
            _fLinkToiTunes = linkLabel
        }
        else
        {
            _fLinkToiTunes = ""
        }
        
        
            //Release Date
        if let relDate = data["im:releaseDate"] as? JSONDictionary,
            relAttr = relDate["attributes"] as? JSONDictionary,
            relLabel = relAttr["label"] as? String
        {
            _fReleaseDate = relLabel
        }
        else
        {
            _fReleaseDate = ""
        }
        
    }
    
    
}