//
//  UserFavouriteTableViewCell.swift
//  PhotoGallery
//
//  Created by Abhishek on 21/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class UserFavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(dataSourceDelegate: D) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 200)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
