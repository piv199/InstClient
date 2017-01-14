//
//  ProfileAPI.swift
//  InstClient
//
//  Created by Alya Filon on 29.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit
import Alamofire

class ProfileAPI {
    
    enum Route {
        
        case owner
        case following
        case followers
        case recentMedia
        
        var method: HTTPMethod {
            switch self {
            case .owner, .following, .followers, .recentMedia: return .get
            }
        }
        
        var path: String {
            switch self {
            case .owner:
                return "/v1/users/self/?access_token=" + UserSession.shared.accessToken!
                
            case .following:
                return "/v1/users/self/follows?access_token="
                    +  UserSession.shared.accessToken!
                
            case .recentMedia:
                return "/v1/users/self/media/recent/?access_token="
                    + UserSession.shared.accessToken!
            case .followers:
                return "/v1/users/self/followed-by?access_token="
                    +  UserSession.shared.accessToken!
            }
        }
    }
    
    static func getOwnerData(closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = URL(string: API.apiURL.absoluteString + Route.owner.path)
        
        Alamofire.request(request!).responseJSON { response in
            
            switch response.result {
            case .success(_):
                closure(response)
                
            case .failure:
                break
            }
        }
    }
    
    static func getFollowingList(closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = URL(string: API.apiURL.absoluteString + Route.following.path)
        
        Alamofire.request(request!).responseJSON { response in
            
            switch response.result {
            case .success(_):
                closure(response)
                
            case .failure:
                break
            }
        }
    }
    
    static func getFollowersList(closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = URL(string: API.apiURL.absoluteString + Route.followers.path)
        
        Alamofire.request(request!).responseJSON { response in
            
            switch response.result {
            case .success(_):
                closure(response)
                
            case .failure:
                break
            }
        }
    }

    
    static func getRecentMedia(closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        let request = URL(string: API.apiURL.absoluteString + Route.recentMedia.path)
        
        Alamofire.request(request!).responseJSON { response in
            
            switch response.result {
            case .success(_):
                closure(response)
                
            case .failure:
                break
            }
        }
    }
}
