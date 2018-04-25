//
//  Extension.swift
//  PhotoGallery
//
//  Created by Abhishek on 12/03/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadedImage(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadImage(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedImage(url: url, contentMode: mode)
}

}

extension UIViewController{
    
    
    func setNavbar(titleText:String, isLagreTitleOn:Bool, isBackButtonHidden:Bool, isTranslucent:Bool){
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = isLagreTitleOn
        }
            self.navigationController?.navigationBar.isTranslucent = isTranslucent
            navigationItem.title = titleText
            navigationItem.hidesBackButton = isBackButtonHidden
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
            self.navigationController?.navigationBar.barTintColor = UIColor().appDefaultThemeColor()
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    
   func hideKeyboard(){
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(UIViewController.dismissKeyboard))
               view.addGestureRecognizer(tap)
        }
        
    @objc func dismissKeyboard(){
            view.endEditing(true)
        }
    
    }
    


extension UIView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true;
    }
    
    func setCornerRadius(){
        let cornerRadius: CGFloat = 4
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(
            roundedRect: self.bounds,
            
            byRoundingCorners: [.allCorners],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
            ).cgPath
        
        self.layer.mask = maskLayer
        
    }
}

extension UIColor{
    
    func appDefaultThemeColor() -> UIColor {
        return  UIColor(displayP3Red: 0/255, green: 150/255, blue: 136/255, alpha: 1.0)
    }
}
