//
//  PhotoGallerySharedDataModel.swift
//  PhotoGallery
//
//  Created by Abhishek on 21/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation

var sharedDataManager = PhotoGallerySharedDataModel(photoUrl: "",title:"")

class PhotoGallerySharedDataModel {
    var  photoUrl: [String] = []
    var   title: [String] = []
   
    init(photoUrl: String,title: String) {
        self.photoUrl = [photoUrl]
        self.title =  [title]
    }
}



