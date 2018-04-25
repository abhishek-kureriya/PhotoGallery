//
//  PhotoGalleryFlickrHomeViewModel.swift
//  PhotoGallery
//
//  Created by Abhishek on 18/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class PhotoGalleryFlickrHomeViewModel: photoGalleryServiceDelegate {
    
    weak var deleget: photoGalleryViewModelDelegate?
    var api = PhotoGalleryServiceLayer()
    private var photoListArray:[FlickerSearchResponseDataModel]?
    var userSelectionList:[UserProfileDataModel]?
   
    
    func callFlickrApi(searchString:String){
        
        api.deleget = self
        api.getImagefromApi(searchString:searchString)
        
        
    }
    func didRetrieveImageData(data : [FlickerSearchResponseDataModel]) {
        photoListArray = data
        DispatchQueue.main.async {
            self.deleget?.updateView(responseObj: self.photoListArray!)
        }
    }
    
    func errorOnRetrieveingImageData(errorMessage: String) {
        
    }
    
    
    func addImageToUserFavList(itemIndex:Int){
      
        sharedDataManager.photoUrl.append(photoListArray![itemIndex].photoUrl)
        sharedDataManager.title.append (photoListArray![itemIndex].title)

   }
}
    



   
    

  
        
        
    
    

