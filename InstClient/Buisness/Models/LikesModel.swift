//
//  LikesModel.swift
//  InstClient
//
//  Created by Alya Filon on 12.01.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import SwiftyJSON

class LikesModel {
    
    static let instance = LikesModel()
    
    var likesStructArray = Array<LikesStruct>()
    
    struct LikesStruct {
        
        var id: String?
        
        var username: String?
        var firstName: String?
        var lastName: String?
    }
    
    func parseJSON(JSONObj: Any) {
        
        let json = JSON(JSONObj)
        
        let usersArray = json["data"].arrayObject as! Array<NSDictionary>
        
        for user in usersArray {
            
            var likesStruct = LikesStruct()
            
            likesStruct.id = user.value(forKey: "id") as? String
            likesStruct.username = user.value(forKey: "username") as? String
            likesStruct.firstName = user.value(forKey: "first_name") as? String
            likesStruct.lastName = user.value(forKey: "last_name") as? String
            
            likesStructArray.append(likesStruct)
        }
        
    }
}
