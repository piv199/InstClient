//
//  PhotoViewCollectionViewCell.swift
//  InstClient
//
//  Created by Alya Filon on 03.01.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

protocol ChengingPhotoStateProtocol: NSObjectProtocol {
    func changePhotoState(state: State)
}

let changeGridViewNotification = "gridView"
let changeListViewNotification = "listView"

class PhotoViewCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ChengingPhotoStateProtocol?
    
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var markButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gridButton.isSelected = true
    }

    @IBAction func gridState(_ sender: UIButton) {
        
        listButton.isSelected = false
        gridButton.isSelected = true
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: changeGridViewNotification), object: self)
    }
    
    @IBAction func listState(_ sender: UIButton) {
        
        gridButton.isSelected = false
        listButton.isSelected = true
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: changeListViewNotification), object: self)
    }
}
