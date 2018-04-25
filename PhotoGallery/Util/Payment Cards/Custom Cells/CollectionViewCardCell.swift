//
//  CollectionViewCardCell.swift
//  Created by Abhishek kureriya on 20/04/2018.
//

import UIKit

class CollectionViewCardCell: UICollectionViewCell {
    
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    
    }
   
    func setUpCellData(data:UserProfileDataModel){
        imageView.downloadImage(link:data.photoUrl!)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.contentMode = UIViewContentMode.scaleToFill
        titleLabel.text = data.title
    }

   
}
