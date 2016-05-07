//
//  MusicVideo.swift
//  Music Video
//
//  Created by Alexander Sramek on 4/27/16.
//  Copyright © 2016 Brother Alex. All rights reserved.
//

import Foundation

class Video{
    
    private var _vName:String
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl:String
    private var _vArtist:String
    private var _vVideoUrl:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDate:String
    
    
    var vImageData:NSData?
    
    
        //Getters
    
    var vName: String {
        return _vName
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vImageUrl: String{
        return _vImageUrl
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vVideoUrl: String{
        return _vVideoUrl
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDate: String {
        return _vReleaseDate
    }
    
    
    
    
    
    
    
    
    init(data: JSONDictionary)
    {
        
            //If we don't init all properties we get an error message
            //Return from initializer without initializing all stored properties
        
            //video name
        
        if let name = data["im:name"] as? JSONDictionary,
            nameLabel = name["label"] as? String
        {
            _vName = nameLabel
        }
        else
        {
            _vName = ""
        }
        
            //Rights
        
        if let rights = data["rights"] as? JSONDictionary,
            rightsLabel = rights["label"] as? String
        {
            _vRights = rightsLabel
        }
        else
        {
            _vRights = ""
        }
        
        
            //Price
            //Using the label. Also available are attributes with a number and a currency.
        if let price = data["im:price"] as? JSONDictionary,
            priceLabel = price["label"] as? String
        {
            _vPrice = priceLabel
        }
        else
        {
            _vPrice = ""
        }
        
        
        
            //video image url
        
        if let img = data["im:image"] as? JSONArray,
            imageAt2 = img[2] as? JSONDictionary,
            imageURL = imageAt2["label"] as? String
        {
            _vImageUrl = imageURL.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }
        else
        {
            _vImageUrl = ""
        }
        
        
            //Artist
        
        if let artist = data["im:artist"] as? JSONDictionary,
            artistLabel = artist["Label"] as? String
        {
            _vArtist = artistLabel
        }
        else
        {
            _vArtist = ""
        }
        
        
            //Video URL
        
        if let video = data["link"] as? JSONArray,
            videoAt1 = video[1] as? JSONDictionary,
            videoAttributes = videoAt1["attributes"] as? JSONDictionary,
            videoURL = videoAttributes["href"] as? String
        {
            _vVideoUrl = videoURL
        }
        else
        {
            _vVideoUrl = ""
        }
        
        
            //Imid
        if let vidId = data["id"] as? JSONDictionary,
            idAttributes = vidId["Attributes"] as? JSONDictionary,
            imid = idAttributes["im:id"] as? String
        {
            _vImid = imid
        }
        else
        {
            _vImid = ""
        }
        
        
            //Genre
            //Class says to use "term". There's also a "label".
        if let categ = data["category"] as? JSONDictionary,
            catAttributes = categ["attributes"] as? JSONDictionary,
            catTerm = catAttributes["term"] as? String
        {
           _vGenre = catTerm
        }
        else
        {
            _vGenre = ""
        }
        
            //Link to iTunes
            // we don't go for the one in the "link" field, apparently
        if let linkId = data["id"] as? JSONDictionary,
            linkLabel = linkId["label"] as? String
        {
            _vLinkToiTunes = linkLabel
        }
        else
        {
            _vLinkToiTunes = ""
        }
        
        
            //Release Date
        if let relDate = data["im:releasedate"] as? JSONDictionary,
            relAttr = relDate["attributes"] as? JSONDictionary,
            relLabel = relAttr["label"] as? String
        {
            _vReleaseDate = relLabel
        }
        else
        {
            _vReleaseDate = ""
        }
        
    }
    
    
}