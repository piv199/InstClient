//
//  AppNavigator.swift
//  InstClient
//
//  Created by Alya Filon on 28.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit

class AppNavigator {
    
    func setupRootViewController(in window: UIWindow?) {
        
        //do{ try UserSession.shared.deactivate()
        //} catch{}
        
        if UserSession.shared.isActive {
            
            window?.rootViewController = R.storyboard.tabBar.instantiateInitialViewController()
            
        } else {
        
            window?.rootViewController = R.storyboard.login.instantiateInitialViewController()
        }
        
        window?.makeKeyAndVisible()
    }
}
