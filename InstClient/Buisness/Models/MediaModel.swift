//
//  MediaModel.swift
//  InstClient
//
//  Created by Alya Filon on 01.12.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MediaModel {
    
    static let instance = MediaModel()
    
    var mediaStructArray = Array<MediaStruct>()
    
    struct MediaStruct {
        var id: String?
        
        var username: String?
        var avatar: String?
        var thumbnail: String?
        var standard_resolution: String?
        
        var standResWidth: CGFloat?
        var standResHeight: CGFloat?
        
        var likes: Int?
        var userTextCaption: String?
        var comments: Int?
    }
    
    func parseJSON(JSONObj: Any) {
        
        let json = JSON(JSONObj)
        
        let mediaArray = json["data"].arrayObject as! Array<NSDictionary>
        
        for media in mediaArray {
            var mediaStruct = MediaStruct()
            mediaStruct.id = media.value(forKey: "id") as! String?
            
            let images = media["images"] as! NSDictionary
            let thumbnailDictionary = images.value(forKey: "thumbnail") as! NSDictionary
            let standartResDictionary = images.value(forKey: "standard_resolution") as! NSDictionary
            mediaStruct.thumbnail = thumbnailDictionary.value(forKey: "url") as? String
            mediaStruct.standard_resolution = standartResDictionary.value(forKey: "url") as? String
            mediaStruct.standResHeight = standartResDictionary.value(forKey: "height") as? CGFloat
            mediaStruct.standResWidth = standartResDictionary.value(forKey: "width") as? CGFloat
            
            let user = media["user"] as! NSDictionary
            mediaStruct.username = user.value(forKey: "username") as? String
            mediaStruct.avatar = user.value(forKey: "profile_picture") as? String
            
            let likes = media["likes"] as! NSDictionary
            mediaStruct.likes = likes.value(forKey: "count") as? Int
            
            if let caption = media["caption"] as? NSDictionary {
                mediaStruct.userTextCaption = caption.value(forKey: "text") as? String
            }
            
            let comments = media["comments"] as! NSDictionary
            mediaStruct.comments = comments.value(forKey: "count") as? Int
            
            mediaStructArray.append(mediaStruct)
        }
    }
}
