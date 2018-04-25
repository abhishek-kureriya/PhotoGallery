//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Abhishek on 12/03/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

     @IBOutlet weak var imageView: UIImageView!
     @IBOutlet weak var captionLabel: UILabel!
     var image:String?
     var detailViewObj:FlickerSearchResponseDataModel?
     var initiatingPreviewActionController: UIViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.downloadImage(link: (detailViewObj?.photoUrl)!)
        self.captionLabel.text = detailViewObj?.title
        
       }
   override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        setNavbar(titleText: detailViewObj!.title, isLagreTitleOn: false,isBackButtonHidden: false, isTranslucent: false)
      }
   

    override var previewActionItems:[UIPreviewActionItem] {

        let likeAction = UIPreviewAction(title: "Like", style: .default) { (action, viewController) -> Void in

        }

        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) -> Void in
            
        }

        return [likeAction, deleteAction]

     }


}
