//
//  NMBPaymentsCardController.swift
//  NMB
//
//  Created by Martin Rechsteiner on 21/02/2018.
//  Copyright © 2018 DNB. All rights reserved.
//

import UIKit

class UserProfileDataModel: NSObject {
    var photoUrl: String?
    var title: String?
}

protocol PaymentCardsControllerDelegate: class {
    func paymentCardsController(paymentCardsController: PaymentCardsController, didSelectItemAt indexPath: IndexPath)
    func paymentCardsController(paymentCardsController: PaymentCardsController, didApproveItemAt indexPath: IndexPath)
}

class PaymentCardsController: NSObject {
    
    var userSelection: [UserProfileDataModel] = []
    private let paymentCardColors = [UIColor.red,UIColor.yellow,UIColor.blue]
    weak var delegate: PaymentCardsControllerDelegate?
    
    private weak var collectionView: UICollectionView?
    private let collectionViewLayout = PaymentCardsLayout()
    private let CardCellIdentifier = "CardCellIdentifier"
    private let ButtonCellIdentifier = "ButtonCellIdentifier"
   
    func remove(userSelectionObj: UserProfileDataModel) {
        if let index = userSelection.index(of: userSelectionObj) {
            let indexPath = IndexPath(item: index, section: 0)
            
            if userSelection.isEmpty == false {
                userSelection.remove(at: index)
                
                let buttonIndexPath = IndexPath(item: 0, section: 1)
                if let cell = collectionView?.cellForItem(at: buttonIndexPath) as? PaymentCardsButtonCell {
                    cell.stopAnimation()
                }
                
                UIView.animate(
                    withDuration: 0.7,
                    delay: 0,
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0,
                    options: .curveLinear,
                    animations: {
                        self.collectionView?.performBatchUpdates({
                            self.collectionView?.deleteItems(at: [indexPath])
                            if self.userSelection.isEmpty {
                                self.collectionView?.deleteSections(IndexSet(integer: 1))
                            }
                        }, completion: nil)
                }, completion: nil)
            }
        }
    }
    
    func configure(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
        collectionView.register(UINib(nibName: "PaymentCardCell", bundle: nil), forCellWithReuseIdentifier: CardCellIdentifier)
        collectionView.register(PaymentCardsButtonCell.self, forCellWithReuseIdentifier: ButtonCellIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
    }
    
    
}

extension PaymentCardsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if userSelection.isEmpty {
            return 1
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return userSelection.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCellIdentifier, for: indexPath) as! PaymentCardCell
             cell.backgroundColor = paymentCardColors[indexPath.row % paymentCardColors.count]
            // cell.mapDataObjectToView(dataObj: payments[indexPath.row])
          //   cell.setCornerRadius()
            
            return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCellIdentifier, for: indexPath) as! PaymentCardsButtonCell
        }
    }
    
}


extension PaymentCardsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let center = CGPoint(x: collectionView.contentOffset.x + collectionView.frame.midX, y: collectionView.frame.midY)
            
            if let cell = collectionView.cellForItem(at: indexPath) as? PaymentCardsButtonCell {
                cell.startAnimation()
                
                if let indexPath = collectionView.indexPathForItem(at: center) {
                    delegate?.paymentCardsController(paymentCardsController: self, didApproveItemAt: indexPath)
                }
            }
        } else {
            delegate?.paymentCardsController(paymentCardsController: self, didSelectItemAt: indexPath)
        }
    }
    
}

