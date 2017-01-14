//
//  HomeNavigationController.swift
//  InstClient
//
//  Created by Alya Filon on 30.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit

class HomeNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.titleTextAttributes = [NSFontAttributeName: R.font.billabong(size: 28)!, NSForegroundColorAttributeName: UIColor.white]
    }



}
