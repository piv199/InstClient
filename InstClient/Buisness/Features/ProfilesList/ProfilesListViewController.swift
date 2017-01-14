//
//  ProfilesListViewController.swift
//  InstClient
//
//  Created by Alya Filon on 01.12.16.
//  Copyright © 2016 Alya Filon. All rights reserved.
//

import UIKit

class ProfilesListViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    fileprivate let userList = UserListModel.instance
    fileprivate let likesList = LikesModel.instance
    
    var mediaID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.register(R.nib.profilesListCell)
        
        
        /*ProfileAPI.getFollowersList(closure: {response in
            
            switch response.result {
                
            case .success(let jsonObj):
                
                self.userList.parseJSON(JSONObj: jsonObj)
                self.listTableView.reloadData()
                
            case .failure(_):
                break
                
            }
            
        })*/
        
        LikesAPI.getLikers(withMedia: mediaID!, closure: {response in
            
            switch response.result {
                
            case .success(let jsonObj):
                
                self.likesList.parseJSON(JSONObj: jsonObj)
                self.listTableView.reloadData()
                
            case .failure(_):
                break
                
            }
            
        })

    }


}

extension ProfilesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userList.userListStructArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.profileListCell, for: indexPath)! as ProfilesListTableViewCell
        
        return cell
    }
}
