//
//  TodayViewController+CollectionView.swift
//  AppStoreClone
//
//  Created by Phillip Farrugia on 6/17/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit

extension PhotoGalleryFlickrHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Configuration
    
    internal func configure(PhotoGridCollectionView: UICollectionView) {
       
        PhotoGridCollectionView.register(PhotoGalleryCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        PhotoGridCollectionView.register(UINib(nibName: "PhotoGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        PhotoGridCollectionView.dataSource = self
        PhotoGridCollectionView.delegate = self
        PhotoGridCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionViewDataset?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewDataset!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = PhotoGalleryCollectionViewCell.dequeue(fromCollectionView: collectionView, atIndexPath: indexPath)
          cell.showImageGallery(dataSet: collectionViewDataset![indexPath.row])
        return cell
       
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: BaseRoundedCardCell.cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }

   
   
    // MARK: - UICollectionViewDelegate
    
  
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
    let detailViewController =  storyboard?.instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController
        detailViewController?.detailViewObj = collectionViewDataset![indexPath.row]
    self.navigationController?.pushViewController(detailViewController!, animated: true)
    }
    
    
}
