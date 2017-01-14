//
//  BioCollectionViewCell.swift
//  InstClient
//
//  Created by Alya Filon on 29.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit
import SwiftyJSON

let operationQueue: OperationQueue = {
    let operationQueue = OperationQueue()
    
    operationQueue.maxConcurrentOperationCount = 5
    
    return operationQueue
}()


class BioCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var postsButton: UIButton!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var followingButton: UIButton!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    weak var delegate: ControllersChengingProtocol?
    
    enum MediaButtons {
        
        case posts
        case followers
        case following
        
        var name: String {
            switch self {
            case .posts:
                return " posts"
            case .followers:
                return " followers"
            case .following:
                return " following"
            }
        }
        
        func value(forUser user: UserModel) -> String {
            switch self {
            case .posts:
                return user.media!
            case .followers:
                return user.followers!
            case .following:
                return user.following!
            }
        }
    }
    
    let attributeForValues = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSForegroundColorAttributeName: UIColor.black]
    let attributeForWords = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular), NSForegroundColorAttributeName: UIColor(red: 139/255.0, green: 142/255.0, blue: 146/255.0, alpha: 1)]
    
    @IBAction func getFollowers(_ sender: UIButton) {
        
        let profilesListStoryboard =  UIStoryboard(name: "ProfilesList", bundle: nil)
        let profilesListViewController =  profilesListStoryboard.instantiateViewController(withIdentifier: R.storyboard.profilesList.name) as! ProfilesListViewController
        
        if delegate?.responds(to: Selector(("showController:"))) != nil {
            delegate?.showController(controller: profilesListViewController)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImage.layer.cornerRadius =  avatarImage.frame.size.height/2
        avatarImage.clipsToBounds = true
        
        editProfileButton.layer.cornerRadius = 3
    }
    
    func makeAttributedString(withButton button: MediaButtons, user: UserModel) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: button.value(forUser: user), attributes: attributeForValues)
        let attributedTextCaption = NSAttributedString(string: button.name, attributes: attributeForWords)
        attributedString.append(attributedTextCaption)
        
        return attributedString
    }
    
    func setBioValues(user: UserModel) {
 
        if let _ = user.media {
            postsButton.titleLabel?.textAlignment = .center
            postsButton.setAttributedTitle(makeAttributedString(withButton: .posts, user: user), for: .normal)
        }
        if let _ = user.followers {
            followersButton.titleLabel?.textAlignment = .center
            followersButton.setAttributedTitle(makeAttributedString(withButton: .followers, user: user), for: .normal)
        }
        if let _ = user.following {
            followingButton.titleLabel?.textAlignment = .center
            followingButton.setAttributedTitle(makeAttributedString(withButton: .following, user: user), for: .normal)
        }
        
        self.fullNameLabel.text = user.fullName
        self.bioLabel.text = user.bio
        self.websiteLabel.text = user.website

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
                        
                        self?.avatarImage.image = UIImage(data: data)
                    }
                } catch {}
            }
        }
        
        operationQueue.addOperation(operation)
    }
    
    static func getCellHeight(width: CGFloat, values: UserModel) -> CGFloat {
        
        var height: CGFloat = 147.0
        let width = width - 30
        
        let valuesArray = [values.fullName, values.bio, values.website]
        
        for value in valuesArray {
            
            if let stringUnwr = value as String! {
                let attributeString = makeAttributedString(string: stringUnwr)
                let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
                let boundingBox = attributeString.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
                
                height = height + boundingBox.height
            }
        }

        return height
    }
    
    static func makeAttributedString(string: String) -> NSAttributedString {
        
        let attributes = [NSForegroundColorAttributeName: UIColor(red: 187/255.0, green: 187/255.0, blue: 187/255.0, alpha: 1),
                          NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        
        return attributedString
    }
}

