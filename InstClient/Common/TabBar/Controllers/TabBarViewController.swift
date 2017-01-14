//
//  TabBarViewController.swift
//  InstClient
//
//  Created by Alya Filon on 28.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabBar.backgroundColor = UIColor(red: 37.0/255, green: 39.0/255, blue: 43.0/255, alpha: 1)
        //tabBar.tintColor = UIColor(red: 37.0/255, green: 39.0/255, blue: 43.0/255, alpha: 1)
        
        //UITabBar.appearance().backgroundColor = UIColor(red: 37.0/255, green: 39.0/255, blue: 43.0/255, alpha: 1)
        
        tabBar.selectionIndicatorImage = R.image.selectiondIbdicator()
        
    }

}
