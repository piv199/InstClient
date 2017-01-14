//
//  PublicationCollectionViewCell.swift
//  InstClient
//
//  Created by Alya Filon on 28.12.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit

class PublicationCollectionViewCell: UICollectionViewCell {
    
    fileprivate let userModel = UserModel.instance
    fileprivate let mediaModel = MediaModel.instance
    
    @IBOutlet weak var publicationCollectionVeiw: UICollectionView!
    
    let cellsArray = [R.reuseIdentifier.usernameCell.identifier, R.reuseIdentifier.photoCell.identifier, R.reuseIdentifier.actionsCell.identifier, R.reuseIdentifier.commentsCell.identifier]
    
    var publicationCount = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        publicationCollectionVeiw.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        publicationCollectionVeiw.register(R.nib.username)
        publicationCollectionVeiw.register(R.nib.photo)
        publicationCollectionVeiw.register(R.nib.actions)
        publicationCollectionVeiw.register(R.nib.comments)
    }
    
    static func getCellHeight(withWidth width: CGFloat, media: MediaModel.MediaStruct) -> CGSize {
        
        var height:CGFloat = 100.0
        height = height + PhotoCollectionViewCell.getCellHeight(withScreenWidth: width, media: media)
        height = height + CommentsCollectionViewCell.getCellHeight(width: width, values: media)
        return CGSize(width: width, height: height)
    }
}

extension PublicationCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch cellsArray[indexPath.row]  {
            
        case R.reuseIdentifier.usernameCell.identifier:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! UsernameCollectionViewCell
            cell.setUsernameValues(forUser: userModel)
            return cell
            
        case R.reuseIdentifier.photoCell.identifier:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! PhotoCollectionViewCell
            cell.setPhotoValues(media: mediaModel.mediaStructArray[publicationCount], screenWidth: UIScreen.main.bounds.width)
            return cell
            
        case R.reuseIdentifier.actionsCell.identifier:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! ActionsCollectionViewCell
            return cell
            
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! CommentsCollectionViewCell
            cell.setValues(foeMedia: mediaModel.mediaStructArray[publicationCount])    
            return cell
        }
    }
}

extension PublicationCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        
        switch cellsArray[indexPath.row] {
        case R.reuseIdentifier.usernameCell.identifier:
            return CGSize(width: width, height: 50)
        case R.reuseIdentifier.photoCell.identifier:
            return CGSize(width: width, height: PhotoCollectionViewCell.getCellHeight(withScreenWidth: width, media: mediaModel.mediaStructArray[publicationCount]))
        case R.reuseIdentifier.actionsCell.identifier:
            return CGSize(width: width, height: 50)
        default:
            return CGSize(width: width, height: CommentsCollectionViewCell.getCellHeight(width: width, values: mediaModel.mediaStructArray[publicationCount]))
        }
    }
}






