//
//  ProfileViewController.swift
//  InstClient
//
//  Created by Alya Filon on 28.11.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    let cellsArray = [R.reuseIdentifier.bioCell.identifier, R.reuseIdentifier.photoViewCell.identifier, R.reuseIdentifier.photosCell.identifier]
    
    fileprivate let userModel = UserModel.instance
    fileprivate let userListModel = UserListModel.instance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tabBarItem.image = R.image.profileIcon()
        tabBarItem.selectedImage = R.image.profileIconSelected()
        tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileCollectionView.register(R.nib.bioCell)
        profileCollectionView.register(R.nib.photoViewCell)
        profileCollectionView.register(R.nib.photosCell)
        
        ProfileAPI.getOwnerData(closure: {response in
            
            switch response.result {
            case .success(let jsonObj):
                
                self.userModel.parseJSON(JSONObj: jsonObj)
                self.navigationItem.title = self.userModel.username
                self.profileCollectionView.reloadData()
                
            case .failure(_):
                break
            }
        })

    }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch cellsArray[indexPath.row] {
        case R.reuseIdentifier.bioCell.identifier:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! BioCollectionViewCell
            cell.setBioValues(user: userModel)
            cell.delegate = self
            return cell
            
        case R.reuseIdentifier.photoViewCell.identifier:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! PhotoViewCollectionViewCell
            return cell
            
        default:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsArray[indexPath.row], for: indexPath) as! PhotosCollectionViewCell
            cell.delegate = self
            return cell
        }
    }
}

extension ProfileViewController: ControllersChengingProtocol {
    
    func showController(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        
        switch cellsArray[indexPath.row] {
        case R.reuseIdentifier.bioCell.identifier:
                return CGSize(width: width, height: BioCollectionViewCell.getCellHeight(width: width, values: userModel))
            
        case R.reuseIdentifier.photoViewCell.identifier:
            return CGSize(width: width, height: 52)
            
        default:
            return CGSize(width: width, height: 700)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}



















