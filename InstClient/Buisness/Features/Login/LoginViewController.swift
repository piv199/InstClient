//
//  LoginViewController.swift
//  InstClient
//
//  Created by Alya Filon on 29.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSURLRequest(url: API.oauthCodeRequest(), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        
        self.webView.loadRequest(request as URLRequest)
    }
}

extension LoginViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool  {
        
        let urlString: String = (request.url?.absoluteString)!
        //print("URL STRING : \(urlString) ")
        var UrlParts: [String] = urlString.components(separatedBy: API.redirectURI.absoluteString)
        
        
        var UrlParts2 = [String]()
        if UrlParts.count > 1 {
        //let UrlParts2: [String] = UrlParts[1].components(separatedBy: "?code=")
            UrlParts2 = UrlParts[1].components(separatedBy: "?code=")
        }
        
        
        
        
        if UrlParts2.count > 1 {
            
            //print("CODE : \(UrlParts2[1]) ")
            
            API.accessTokenRequest(code: UrlParts2[1], closure: {response in
                
                switch response.result {
                case .success(let jsonObj):
                    
                    let json = JSON(jsonObj)
                    let access_token = json["access_token"].string
                    
                    if access_token != nil {
                        
                        do {
                            try UserSession.shared.activate(with: access_token!)
                        }  catch _ {}
                        
                        self.present(R.storyboard.tabBar().instantiateInitialViewController()!, animated: true, completion: nil)
                    }
                //print(access_token)
                case .failure:
                    break
                }
            })
            return false
        }
        //print(request)
        return true
    }
}
