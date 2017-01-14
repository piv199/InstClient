//
//  ExploreViewController.swift
//  InstClient
//
//  Created by Alya Filon on 30.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tabBarItem.image = R.image.exploreItem()
        tabBarItem.selectedImage = R.image.exploreItemSelected()
        tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

 

}
