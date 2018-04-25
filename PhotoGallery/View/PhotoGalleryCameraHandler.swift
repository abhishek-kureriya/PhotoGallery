//
//  PhotoGalleryCameraHandler.swift
//  PhotoGallery
//
//  Created by Abhishek on 25/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
import Foundation
import UIKit


class PhotoGalleryCameraHandler: NSObject{
    static let shared = PhotoGalleryCameraHandler()
    
    fileprivate var currentVC: UIViewController!
    
   
    var imagePickedBlock: ((UIImage) -> Void)?
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let pickerController = UIImagePickerController()
            pickerController.delegate = self;
            pickerController.sourceType = .camera
            currentVC.present(pickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let pickerController = UIImagePickerController()
            pickerController.delegate = self;
            pickerController.sourceType = .photoLibrary
            currentVC.present(pickerController, animated: true, completion: nil)
        }
        
    }
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
}


extension PhotoGalleryCameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickedBlock?(image)
        }else{
            print("Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
    
}
