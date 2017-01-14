//
//  ViewController.swift
//  InstClient
//
//  Created by Alya Filon on 25.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
     let baseURLString = "https://api.instagram.com"
     let clientID = "95218b9a173d43a8a9e555cea9f43a11"
     let redirectURI = "http://www.example.com/"
     let clientSecret = "1a492172b8194a6f900115c73bfece00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let str = URL(string: baseURLString + "/oauth/authorize/?client_id=" + clientID + "&redirect_uri=" + redirectURI + "&response_type=code")
        
        let request = NSURLRequest(url: API.oauthCodeRequest(), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        self.webView.loadRequest(request as URLRequest)
    }

  
}

extension ViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool  {
        
        
        
        let urlString: String = (request.url?.absoluteString)!
        print("URL STRING : \(urlString) ")
        var UrlParts: [String] = urlString.components(separatedBy: redirectURI)
        let UrlParts2: [String] = UrlParts[1].components(separatedBy: "?code=")
        
        if UrlParts2.count > 1 {
            
            print("CODE : \(UrlParts2[1]) ")
            
            getAccessToken(code: UrlParts2[1])
            
           // API.accessTokenRequest(code: UrlParts2[1])//, closure: <#T##(DataResponse<Any>) -> Void#>)
            
            return false
        }
        
        
        
        print(request)
        
      
        return true
        
    }


    func getAccessToken(code: String) {
        
        let URL = baseURLString + "/oauth/access_token"
        
        let params = ["client_id" : clientID,
                     "client_secret" : clientSecret,
                     "grant_type" : "authorization_code",
                     "redirect_uri" : redirectURI,
                     "code" : code]
        
        
        Alamofire.request(URL, method: .post, parameters: params).responseJSON { response in
    
            switch response.result {
            case .success(let jsonObj):
                
                let json = JSON(jsonObj)
                
                let access_token = json["access_token"].string
                
                //print(access_token)
                
                
                
                let url = "https://api.instagram.com/v1/users/self/?access_token=" + access_token!
                
                
                Alamofire.request(url, method: .get).responseJSON { response in
                    
                    switch response.result {
                    case .success(let jsonObj):
                        
                        let json = JSON(jsonObj)
                        
                        let name = json["data"]["username"].string
                        let status = json["data"]["full_name"].string
                        
                        self.nameLabel.text = name
                        self.statusLabel.text = status
        
                        
                    case .failure:
                        
                        break
                    }
                
                }
                
                
                
                
                
        
                
        
            case .failure:
                
                break
            }
            
     
            
        }

    }
}
 


