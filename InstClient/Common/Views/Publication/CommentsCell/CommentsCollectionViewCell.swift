//
//  CommentsCollectionViewCell.swift
//  InstClient
//
//  Created by Alya Filon on 08.01.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class CommentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var captionTextLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    weak var delegate: ControllersChengingProtocol?
    
    var media: MediaModel.MediaStruct?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        captionTextLabel.adjustsFontSizeToFitWidth = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CommentsCollectionViewCell.getUsersLiked))
        likesLabel.addGestureRecognizer(tap)
        
        
    }
    
    func getUsersLiked(sender: UITapGestureRecognizer) {
        
        let profilesListStoryboard =  UIStoryboard(name: "ProfilesList", bundle: nil)
        let profilesListViewController =  profilesListStoryboard.instantiateViewController(withIdentifier: R.storyboard.profilesList.name) as! ProfilesListViewController
        
        profilesListViewController.mediaID = media?.id!
        
        if delegate?.responds(to: Selector(("showController:"))) != nil {
            delegate?.showController(controller: profilesListViewController)
        }
        
    }
    
    func setValues(foeMedia media: MediaModel.MediaStruct){
        
        self.media = media
        
        if let comments = media.comments as Int! {
            
            if comments == 0 {
                commentsLabel.text = nil//""
            }
                else
                if comments != 1 {
                    commentsLabel.text = "View all \(comments) comments"
                }
            else {
                commentsLabel.text = "View one comment"
            }
        }
        
        if media.likes! != 0 {
            likesLabel.text = "❤︎ \(media.likes!) likes"
        }
        else {
            likesLabel.text = nil//""
        }
        
        if let caption = media.userTextCaption {
            
            let attributeForUsername = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)]
            let attributedString = NSMutableAttributedString(string: media.username!, attributes: attributeForUsername)
            
            let attributeForCaption = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)]
            let attributedTextCaption = NSAttributedString(string: " " + caption, attributes: attributeForCaption)
            
            attributedString.append(attributedTextCaption)
            
            let constraintRect = CGSize(width: 300.0, height: .greatestFiniteMagnitude)
            
            attributedString.boundingRect(with:constraintRect, options: .usesLineFragmentOrigin, context: nil)
            
            captionTextLabel.attributedText = attributedString
            
        }
        else {
            captionTextLabel.text = nil//""
        }
    }
    
    static func getCellHeight(width: CGFloat, values: MediaModel.MediaStruct) -> CGFloat {
        
        var height: CGFloat = 30.0
        let width = width - 30
      
        if let stringUnwr = values.userTextCaption as String! {
            let attributeString = makeAttributedString(string: stringUnwr)
            let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
            let boundingBox = attributeString.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
            
            height = height + boundingBox.height
        }
        
        if let likes = values.likes as Int! {
            if likes != 0 {
                height = height + 22
            }
        }
        if let comments = values.comments as Int! {
            if comments != 0 {
                height = height + 22
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
