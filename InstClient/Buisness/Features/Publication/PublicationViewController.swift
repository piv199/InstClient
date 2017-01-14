//
//  PublicationViewController.swift
//  InstClient
//
//  Created by Alya Filon on 06.01.17.
//  Copyright © 2017 Alya Filon. All rights reserved.
//

import UIKit

class PublicationViewController: UIViewController {
    
    @IBOutlet weak var publicationCollectionView: UICollectionView!
    
    fileprivate let mediaModel = MediaModel.instance
    fileprivate let userModel = UserModel.instance
    
    let width = UIScreen.main.bounds.width
    
    enum RowsSize {
        
        case username
        
        var size: CGSize {
            
            switch self {
            case .username:
                return CGSize(width: UIScreen.main.bounds.width, height: 50)

            }
        }
    }
    
    var mediaNumber = 0
    
    let cellsArray = [R.reuseIdentifier.usernameCell.identifier, R.reuseIdentifier.photoCell.identifier, R.reuseIdentifier.actionsCell.identifier, R.reuseIdentifier.commentsCell.identifier]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Photo"

        publicationCollectionView.register(R.nib.username)
        publicationCollectionView.register(R.nib.photo)
        publicationCollectionView.register(R.nib.actions)
        publicationCollectionView.register(R.nib.comments)
    }
}

extension PublicationViewController: ControllersChengingProtocol {
    
    func showController(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension PublicationViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch cellsArray[indexPath.row] {
        case R.reuseIdentifier.usernameCell.identifier:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! UsernameCollectionViewCell
            
            cell.setUsernameValues(forUser: userModel)
            cell.delegate = self
            
            return cell
            
        case R.reuseIdentifier.photoCell.identifier:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! PhotoCollectionViewCell
            
            cell.setPhotoValues(media: mediaModel.mediaStructArray[mediaNumber], screenWidth: UIScreen.main.bounds.width)
            
            return cell
            
        case R.reuseIdentifier.actionsCell.identifier:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath)
            return cell
            
        default: //case R.reuseIdentifier.commentsCell.identifier:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! CommentsCollectionViewCell
            
            cell.setValues(foeMedia: mediaModel.mediaStructArray[mediaNumber])
            cell.delegate = self
            
            return cell
        }
    }
}

extension PublicationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        
        switch cellsArray[indexPath.row] {
        case R.reuseIdentifier.usernameCell.identifier:
            return CGSize(width: width, height: 50)
        case R.reuseIdentifier.photoCell.identifier:
            return CGSize(width: width, height: PhotoCollectionViewCell.getCellHeight(withScreenWidth: width, media: mediaModel.mediaStructArray[mediaNumber]))
        case R.reuseIdentifier.actionsCell.identifier:
            return CGSize(width: width, height: 50)
        default:
            return CGSize(width: width, height: CommentsCollectionViewCell.getCellHeight(width: width, values: mediaModel.mediaStructArray[mediaNumber]))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
















