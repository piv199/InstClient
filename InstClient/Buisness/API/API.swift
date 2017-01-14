//
//  API.swift
//  InstClient
//
//  Created by Alya Filon on 27.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API {
 
    enum OauthResult {
        
        case loggedIn(accessToken: String)
        case error
    }
    
    static var apiURL: URL {
        return URL(string: "https://api.instagram.com")!
    }
    
    static var clientID: String {
        return "95218b9a173d43a8a9e555cea9f43a11"
    }
    
    static var clientSecret: String {
        return "1a492172b8194a6f900115c73bfece00"
    }
    
    static var redirectURI: URL {
        return URL(string: "http://www.example.com/")!
    }
    
    enum Route {
        
        case oauthCode
        case accessToken(code: String)
        
        var method: HTTPMethod {
            switch self {
            case .oauthCode: return .get
            case .accessToken: return .post
            }
        }
        
        var path: String {
            switch self {
            case .oauthCode:
                return API.apiURL.absoluteString + "/oauth/authorize/?client_id=" + API.clientID + "&redirect_uri=" + API.redirectURI.absoluteString + "&response_type=code&scope=basic+public_content+likes+comments+relationships+follower_list"
                
            case .accessToken:
                return API.apiURL.absoluteString + "/oauth/access_token"
            }
        }
        
        var parameters: [String: Any]? {
            
            switch self {
            case .oauthCode:
                return nil
                
            case .accessToken(let code):
                let params = ["client_id" : clientID,
                              "client_secret" : clientSecret,
                              "grant_type" : "authorization_code",
                              "redirect_uri" : redirectURI,
                              "code" : code] as [String : Any]
                return params
            }
        }
    }
    
    static func oauthCodeRequest() -> URL  {
        return URL(string: Route.oauthCode.path)!
    }
    
    static func accessTokenRequest(code: String, closure: @escaping (_ handler: DataResponse<Any>) -> Void)   {
        
        let request = Route.accessToken(code: code)
        
        Alamofire.request(request.path, method: request.method, parameters: request.parameters).responseJSON { response in
            
            closure(response)
            
            /*switch response.result {
             
             case .success(let jsonObj):
             
             let json = JSON(jsonObj)
             
             let access_token = json["access_token"].string
             
             print(access_token)
             
             case .failure:
             break
             }*/
             }
        }
}





