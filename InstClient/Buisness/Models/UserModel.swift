//
//  UserModel.swift
//  InstClient
//
//  Created by Alya Filon on 30.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserModel {
    
    static let instance = UserModel()
    
    var id: String?
    var username: String?
    var fullName: String?
    var avatar: String?
    var bio: String?
    var website: String?
    var media: String?
    var followers: String?
    var following: String?
    
    
    func parseJSON(JSONObj: Any) {
        
        let json = JSON(JSONObj)
        
        self.id = json["data"]["id"].string
    
        self.username = json["data"]["username"].string
        self.fullName = json["data"]["full_name"].string
        self.avatar = json["data"]["profile_picture"].string
        self.bio = json["data"]["bio"].string
        self.website = json["data"]["website"].string
        
        self.media = String(describing: json["data"]["counts"]["media"])
        self.following = String(describing: json["data"]["counts"]["follows"])
        self.followers = String(describing: json["data"]["counts"]["followed_by"])
    }
}
