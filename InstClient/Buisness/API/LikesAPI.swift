//
//  LikesAPI.swift
//  InstClient
//
//  Created by Alya Filon on 12.01.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import Alamofire

class LikesAPI {
    
    static var mediaID: String?
    
    enum Route {
        
        case getLikes
        case setLike
        case deleteLike
        
        var method: HTTPMethod {
            switch self {
            case .getLikes: return .get
            case .setLike: return .post
            case .deleteLike: return .delete
            }
        }
        
        var path: String {
            switch self {
            case .getLikes:
                return "/v1/media/" + LikesAPI.mediaID! + "/likes?access_token=" + UserSession.shared.accessToken!
                
            case .setLike:
                return "/v1/users/self/follows?access_token="
                    +  UserSession.shared.accessToken!
                
            case .deleteLike:
                return "/v1/users/self/media/recent/?access_token="
                    + UserSession.shared.accessToken!
            }
        }
    }
    
    static func getLikers(withMedia mediaID: String, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        LikesAPI.mediaID = mediaID
        
        let request = URL(string: API.apiURL.absoluteString + Route.getLikes.path)
        
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
