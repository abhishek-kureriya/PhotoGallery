//
//  ImageResponseDataModel.swift
//  PhotoGallery
//
//  Created by Abhishek on 16/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation


struct FlickerSearchResponseDataModel {
    
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: String {
        return String(describing: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_m.jpg")
    }
   
}
