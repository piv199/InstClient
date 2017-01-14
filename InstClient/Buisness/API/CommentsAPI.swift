//
//  CommentsAPI.swift
//  InstClient
//
//  Created by Alya Filon on 12.01.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import Foundation
import Alamofire

class CommentsAPI {
    
    static var mediaID: String?
    
    enum Route {
        
        case getComments
        case sendComment
        case deleteComment
        
        var method: HTTPMethod {
            switch self {
            case .getComments: return .get
            case .sendComment: return .post
            case .deleteComment: return .delete
            }
        }
        
        var path: String {
            switch self {
            case .getComments:
                return "/v1/media/" + LikesAPI.mediaID! + "/comments?access_token=" + UserSession.shared.accessToken!
                
            case .sendComment:
                return "/v1/users/self/follows?access_token="
                    +  UserSession.shared.accessToken!
                
            case .deleteComment:
                return "/v1/users/self/media/recent/?access_token="
                    + UserSession.shared.accessToken!
            }
        }
    }
    
    static func getLikers(withMedia mediaID: String, closure: @escaping (_ handler: DataResponse<Any>) -> Void) {
        
        LikesAPI.mediaID = mediaID
        
        let request = URL(string: API.apiURL.absoluteString + Route.getComments.path)
        
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
