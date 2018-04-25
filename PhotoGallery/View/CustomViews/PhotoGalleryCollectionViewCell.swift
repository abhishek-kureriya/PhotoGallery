
//
//  WorldPremiereCell.swift
//  AppStoreClone
//
//  Created by Phillip Farrugia on 6/17/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit
import CoreMotion

internal class PhotoGalleryCollectionViewCell: BaseRoundedCardCell {
    
    /// Image View
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - Factory Method
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    internal static func dequeue(fromCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> PhotoGalleryCollectionViewCell {
       
        guard let cell: PhotoGalleryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotoGalleryCollectionViewCell else {
            fatalError("*** Failed to dequeue Cell ***")
        }
        
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 14.0
    }

    
    func showImageGallery(dataSet:FlickerSearchResponseDataModel){
        imageView.downloadImage(link: dataSet.photoUrl)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.contentMode = UIViewContentMode.scaleToFill
        titleLabel.text = dataSet.title
    }
}
