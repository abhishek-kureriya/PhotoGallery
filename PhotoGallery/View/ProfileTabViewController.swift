//
//  ProfileTabViewController.swift
//  PhotoGallery
//
//  Created by Abhishek on 20/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class ProfileTabViewController: UIViewController {

    @IBOutlet weak var lastLogin: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageview: UIImageView!
    @IBOutlet weak var profileTableView: UITableView!
    var collectionViewCardsController = CollectionViewCardsController()
    var userSelectionList : [UserProfileDataModel]?
    var viewModel = ProfileTabViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         viewModel.deleget = self
     
         viewSetup()
        profileTableView.reloadData()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
         viewModel.mapCustomerLikeImages()
           self.tabBarController?.setNavbar(titleText: "Profile", isLagreTitleOn: true,isBackButtonHidden:true, isTranslucent: false)
    
        
    }
    func viewSetup() {
        
        self.profileTableView.register(UINib(nibName: "UserFavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "UserFavouriteTableViewCell")
        self.profileTableView.register(UINib(nibName: "CommonCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CommonCellTableViewCell")
          collectionViewCardsController.delegate = self
          profileImageview.setRadius()
    }
    
}

extension ProfileTabViewController:profileViewModelDelegate{
    
    func showDataOnview(data: [UserProfileDataModel]) {
           userSelectionList = data
          collectionViewCardsController.userSelection = data
          collectionViewCardsController.reloadCollectionView()
    }
}
extension ProfileTabViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
            
        }else{
            return 3
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserFavouriteTableViewCell", for: indexPath) as! UserFavouriteTableViewCell
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCellTableViewCell", for: indexPath) as! CommonCellTableViewCell
            cell.setUpCellView(row: indexPath.row)
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       if let cell = cell as? UserFavouriteTableViewCell {
        collectionViewCardsController.configure(collectionView: cell.collectionView)
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: collectionViewCardsController)
            }
      }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "My Favourite "
        }else{
            return "Settings"
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.section == 1){
            if(indexPath.row == 1){
                
                PhotoGalleryCameraHandler.shared.showActionSheet(vc: self)
                PhotoGalleryCameraHandler.shared.imagePickedBlock = { (image) in
                 self.profileImageview.image = image
                }

               viewModel.setProfileImage()
            }
        }
    }
}


extension ProfileTabViewController: CollectionViewCardsControllerDelegate {
    
    func collectionViewCardsController(cardsController: CollectionViewCardsController, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionViewCardsController(cardsController: CollectionViewCardsController, didApproveItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let list = self.userSelectionList?.remove(at: indexPath.row)
            self.collectionViewCardsController.remove(userSelectionObj: list!)
            sharedDataManager.photoUrl.remove(at: indexPath.row)
            sharedDataManager.title.remove(at: indexPath.row)
        }
    }
}
