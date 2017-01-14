//
//  HomeViewController.swift
//  InstClient
//
//  Created by Alya Filon on 28.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tabBarItem.image = R.image.homeIcon()
        tabBarItem.selectedImage = R.image.homeIconSelected()
        tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        navigationItem.title = "Instagram"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }




}
