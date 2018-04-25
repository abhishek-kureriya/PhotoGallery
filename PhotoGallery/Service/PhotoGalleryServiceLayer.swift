//
//  PhotoGalleryServiceLayer.swift
//  PhotoGallery
//
//  Created by Abhishek on 11/03/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit
import Alamofire



class PhotoGalleryServiceLayer{
    
    var deleget:photoGalleryServiceDelegate?
    
    
    func getImagefromApi(searchString:String){
        
        let HeaderParams: [String : Any] = [
            "method": SEARCH_METHOD,
            "api_key": FLICKR_API_KEY,
            "page": 1,
            "text":searchString,
            "format":FORMAT_TYPE,
            "nojsoncallback": JSON_CALLBACK
        ]
        

        
        Alamofire.request(
            URL(string: FLICKR_URL)!,
            method: .get,
            parameters: HeaderParams)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    self.deleget?.errorOnRetrieveingImageData(errorMessage: String(describing: response.result.error))
                    return
                }
                do {
                    let responseData = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: AnyObject]
                    guard let results = responseData else { return }
                    let response = PhotoGalleryDataModelLayer.mapResponseData(data: results)
                    self.deleget?.didRetrieveImageData(data: response!)
                    
                } catch let error as NSError {
                    print("Error parsing JSON: \(error)")
                    self.deleget?.errorOnRetrieveingImageData(errorMessage: "Error parsing JSON")
                    return
                }
                
        }
        
    }
}
