//
//  PhotosCollectionViewCell.swift
//  InstClient
//
//  Created by Alya Filon on 08.12.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit

enum State {
    case grid
    case list
}

protocol ControllersChengingProtocol: NSObjectProtocol {
    func showController(controller: UIViewController)
}

class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    fileprivate let mediaModel = MediaModel.instance
    
    var photosState: State = .grid
    
    weak var delegate: ControllersChengingProtocol?
    
    func changeToListPhotoView() {
        
        if photosState != .list {
            photosState = .list
            photosCollectionView.reloadData()
        }
    }
    
    func changeToGridPhotoView() {
        
        if photosState != .grid {
            photosState = .grid
            photosCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photosCollectionView.register(R.nib.thumbnail)
        photosCollectionView.register(R.nib.publicationCell)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PhotosCollectionViewCell.changeToListPhotoView), name: NSNotification.Name(rawValue: changeListViewNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(PhotosCollectionViewCell.changeToGridPhotoView), name: NSNotification.Name(rawValue: changeGridViewNotification), object: nil)
        
        ProfileAPI.getRecentMedia(closure: {response in
            
            switch response.result {
                
            case .success(let jsonObj):
                
                self.mediaModel.parseJSON(JSONObj: jsonObj)
                
                self.photosCollectionView.reloadData()
                
            case .failure(_):
                
                break
            }
        })
    }
}

extension PhotosCollectionViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mediaModel.mediaStructArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch photosState {
            
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.thumbnail.identifier, for: indexPath) as! ThumbnailCollectionViewCell
            
            cell.setBioValues(media: mediaModel.mediaStructArray[indexPath.row])//, number: indexPath.row)
            
            return cell
            
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.publicationCell.identifier, for: indexPath) as! PublicationCollectionViewCell
            
            cell.publicationCount = indexPath.row
            
            return cell
        }
    }
}

extension PhotosCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
  
        switch photosState {
            
        case .grid:
            return CGSize(width: width/3.0 - 1.5, height: width/3.0 - 1.5)
            
            
        case .list:
            return PublicationCollectionViewCell.getCellHeight(withWidth: width, media: mediaModel.mediaStructArray[indexPath.row])//CGSize(width: width, height: width + 150)
        }
    }
}

extension PhotosCollectionViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let publicationStoryboard =  UIStoryboard(name: "Publication", bundle: nil)
        let publicationViewController = publicationStoryboard.instantiateViewController(withIdentifier: R.storyboard.publication.name) as! PublicationViewController
        
        publicationViewController.mediaNumber = indexPath.row
        
        if delegate?.responds(to: Selector(("showController:"))) != nil {
            delegate?.showController(controller: publicationViewController)
        }
    }
}
















