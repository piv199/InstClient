//
//  UserListModel.swift
//  InstClient
//
//  Created by Alya Filon on 01.12.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserListModel {

    static let instance = UserListModel()
    
    var userListStructArray = Array<UserListStruct>()
    
    struct UserListStruct {

        var id: String?
        
        var username: String?
        var fullName: String?
        
        var avatar: String?
    }

    func parseJSON(JSONObj: Any) {
        
        let json = JSON(JSONObj)
        
        let usersArray = json["data"].arrayObject as! Array<NSDictionary>
        
        for user in usersArray {
            
            var userListStruct = UserListStruct()
            
            userListStruct.id = user.value(forKey: "id") as? String
            userListStruct.username = user.value(forKey: "username") as? String
            userListStruct.fullName = user.value(forKey: "full_name") as? String
            userListStruct.avatar = user.value(forKey: "profile_picture") as? String
            
            userListStructArray.append(userListStruct)
        }

    }
}
