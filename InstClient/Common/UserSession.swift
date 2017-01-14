//
//  UserSession.swift
//  InstClient
//
//  Created by Alya Filon on 27.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import Foundation
import KeychainAccess

class UserSession {
    
    static let shared = UserSession()
    
    var onActivation: (() -> ())?
    var onDeactivation: (() -> ())?
    
    fileprivate struct Keys {
        
        static let accessTokenKey = "accessToken"
        static let isAuthorizeKey = "authorize"
    }
    
    fileprivate let defaults = UserDefaults.standard
    fileprivate let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    var accessToken: String? {
        
        return keychain[Keys.accessTokenKey]
    }
    
    fileprivate var authorized: Bool {
        
        return defaults.bool(forKey: Keys.isAuthorizeKey)
    }
    
    var isActive: Bool {
        
        return authorized && accessToken != nil
    }
    
    func activate(with accessToken: String) throws {
        
        do {
            
            try keychain
                .accessibility(.always)
                .synchronizable(false)
                .set(accessToken, key: Keys.accessTokenKey)
            
            defaults.set(true, forKey: Keys.isAuthorizeKey)
            
        } catch let error {
            throw error
        }
        
        DispatchQueue.main.async { [unowned self] in
            self.onActivation?()
        }
    }
    
    func deactivate() throws {
        
        do {
            
            try keychain.remove(Keys.accessTokenKey)
            
            defaults.set(false, forKey: Keys.isAuthorizeKey)
            
            DispatchQueue.main.async { [unowned self] in
                self.onDeactivation?()
            }
        } catch let error {
            throw error
        }
    }
}
