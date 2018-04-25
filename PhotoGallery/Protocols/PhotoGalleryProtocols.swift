//
//  PhotoGalleryProtocols.swift
//  PhotoGallery
//
//  Created by Abhishek on 11/03/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//



import Foundation
import UIKit





protocol photoGalleryViewModelDelegate: class {
    /**
     * Add here your methods for communication
     */
    func updateView(responseObj : [FlickerSearchResponseDataModel])
    func showErroronview(errorMessage:String)
    
}

protocol photoGalleryServiceDelegate:class {
    /**
     * Add here your methods for communication
     */
    
    func  didRetrieveImageData(data : [FlickerSearchResponseDataModel])
    func  errorOnRetrieveingImageData(errorMessage:String)
    
}

protocol profileViewModelDelegate:class {
    /**
     * Add here your methods for communication
     */
    
    func  showDataOnview(data:[UserProfileDataModel])
    
}
