//
//  CommonCellTableViewCell.swift
//  PhotoGallery
//
//  Created by Abhishek on 21/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class CommonCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var cellDescTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellImage?.setRadius()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func setUpCellView(row:Int){
        if row == 0 {
            self.cellImage?.image = UIImage(named:"terms")
            self.cellDescTextLabel.text = "Terms of use"
        }else if row == 1{
            self.cellImage?.image = UIImage(named:"userPic")
            self.cellDescTextLabel.text = "Change profile image"
        }else{
            self.cellImage?.image = UIImage(named:"settings")
            self.cellDescTextLabel.text = "Settings"
            }
    }
}
