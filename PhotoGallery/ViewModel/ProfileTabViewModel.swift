//
//  ProfileTabViewModel.swift
//  PhotoGallery
//
//  Created by Abhishek on 23/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
import UIKit

class ProfileTabViewModel{
     weak var deleget: profileViewModelDelegate?
    
    func mapCustomerLikeImages(){
        
        var  userLikeImg: [UserProfileDataModel]? = []
        for i in 1..<sharedDataManager.photoUrl.count {
            if(sharedDataManager.photoUrl[i] != ""){
                let userLikePhoto = UserProfileDataModel()
                userLikePhoto.photoUrl = sharedDataManager.photoUrl[i]
                userLikePhoto.title =  sharedDataManager.title[i]
                userLikeImg?.append(userLikePhoto)
            }
        }
        
      deleget?.showDataOnview(data:userLikeImg!)
    }
   
    func setProfileImage()  {
        showActionSheet(vc:UIViewController())
    }
    func showActionSheet(vc: UIViewController) {
       // currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
           // self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
           // self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
}
