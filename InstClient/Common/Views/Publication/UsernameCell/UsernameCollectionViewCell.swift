//
//  UsernameCollectionViewCell.swift
//  InstClient
//
//  Created by Alya Filon on 06.01.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

let operationQueue2: OperationQueue = {
    let operationQueue = OperationQueue()
    
    operationQueue.maxConcurrentOperationCount = 5
    
    return operationQueue
}()

class UsernameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    weak var delegate: ControllersChengingProtocol?
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
        avatarImageView.clipsToBounds = true
        
        usernameLabel.sizeToFit()
    }
    
    @IBAction func showActionSheet(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: nil)
        let sharebutton = UIAlertAction(title: "Share", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(deleteButton)
        actionSheet.addAction(sharebutton)
        actionSheet.addAction(cancelButton)
         
        if delegate?.responds(to: Selector(("showController:"))) != nil {
            delegate?.showController(controller: actionSheet)
        }
        
        
    }
    
    func setUsernameValues(forUser user: UserModel) {
        
        usernameLabel.text = user.username
        
        let operation = BlockOperation { [weak self] in
            
            if user.avatar == nil {
                
                DispatchQueue.main.async {
                    
                }
            }
            else {
                
                guard let url = URL(string: user.avatar!) else {
                    return
                }
                
                do {
                    let data = try Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        
                        self?.avatarImageView.image = UIImage(data: data)
                    }
                } catch {}
            }
        }
        
        operationQueue2.addOperation(operation)
    }
}
