
//
//  WorldPremiereCell.swift
//  AppStoreClone
//
//   Created by Abhishek on 16/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit
import CoreMotion


protocol CollectionViewCellDelegate: class {
   
    func didTapLikeMeButton(row:Int)
}

internal class PhotoGalleryCollectionViewCell: BaseRoundedCardCell {
    
    @IBOutlet weak var photoLikeButton: UIView!
    @IBOutlet weak var likemeButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: CollectionViewCellDelegate?
    
    internal static func dequeue(fromCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> PhotoGalleryCollectionViewCell {
       
        guard let cell: PhotoGalleryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoGalleryCollectionViewCell else {
            fatalError("*** Failed to dequeue Cell ***")
        }
        
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 14.0
        likemeButton.layer.cornerRadius = 10.0
        likemeButton.backgroundColor = UIColor().appDefaultThemeColor()
      
    }

    
    @IBAction func didTapLikeMeButton(_ sender: UIButton ) {
        
       delegate?.didTapLikeMeButton(row: sender.tag)
        sender.setTitle("✔", for: .normal)
    }
    func showImageGallery(dataSet:FlickerSearchResponseDataModel,row:Int){
        imageView.downloadImage(link: dataSet.photoUrl)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.contentMode = UIViewContentMode.scaleToFill
        titleLabel.text = dataSet.title
        likemeButton.tag = row
    }
    
    
    
}
