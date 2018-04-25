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

class PhotoGalleryDataModelLayer: NSObject {
    
    class func mapResponseData(data: [String : AnyObject]) -> [FlickerSearchResponseDataModel]? {
        
        guard let photosObj = data["photos"] as? NSDictionary else { return nil }
        guard let photosArray = photosObj["photo"] as? [NSDictionary] else { return nil}
        
        let flickrPhotosMapperObj: [FlickerSearchResponseDataModel] = photosArray.map { photoDictionary in
            
            let photoId = photoDictionary["id"] as? String ?? ""
            let farm = photoDictionary["farm"] as? Int ?? 0
            let secret = photoDictionary["secret"] as? String ?? ""
            let server = photoDictionary["server"] as? String ?? ""
            let title = photoDictionary["title"] as? String ?? ""
            
            let flickrPhoto = FlickerSearchResponseDataModel(photoId: photoId, farm: farm, secret: secret, server: server, title: title)
            return flickrPhoto
        }
        
        return flickrPhotosMapperObj
    }
}



