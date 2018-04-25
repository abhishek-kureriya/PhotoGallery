//
//  CollectionViewCardsController.swift
//  Created by Abhishek kureriya on 20/04/2018.
//


import UIKit

class UserProfileDataModel: NSObject {
    var photoUrl: String?
    var title: String?
}

protocol CollectionViewCardsControllerDelegate: class {
    func collectionViewCardsController(cardsController: CollectionViewCardsController, didSelectItemAt indexPath: IndexPath)
    func collectionViewCardsController(cardsController: CollectionViewCardsController, didApproveItemAt indexPath: IndexPath)
}

class CollectionViewCardsController: NSObject {
    
    var userSelection: [UserProfileDataModel] = []
    private let cardColors = [UIColor.red,UIColor.yellow,UIColor.blue]
    weak var delegate: CollectionViewCardsControllerDelegate?
    
    private weak var collectionView: UICollectionView?
    private let collectionViewLayout = CollectionViewCardsLayout()
    private let CardCellIdentifier = "CardCellIdentifier"
    private let ButtonCellIdentifier = "ButtonCellIdentifier"
   
    func reloadCollectionView()  {
        collectionView?.reloadData()
    }
    func remove(userSelectionObj: UserProfileDataModel) {
        if let index = userSelection.index(of: userSelectionObj) {
            let indexPath = IndexPath(item: index, section: 0)
            
            if userSelection.isEmpty == false {
                userSelection.remove(at: index)
                
                let buttonIndexPath = IndexPath(item: 0, section: 1)
                if let cell = collectionView?.cellForItem(at: buttonIndexPath) as? CollectionViewCardsButtonCell {
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
        collectionView.register(UINib(nibName: "CollectionViewCardCell", bundle: nil), forCellWithReuseIdentifier: CardCellIdentifier)
        collectionView.register(CollectionViewCardsButtonCell.self, forCellWithReuseIdentifier: ButtonCellIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
    }
    
    
}

extension CollectionViewCardsController: UICollectionViewDataSource {
    
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCellIdentifier, for: indexPath) as! CollectionViewCardCell
             cell.backgroundColor = cardColors[indexPath.row % cardColors.count]
            cell.setUpCellData(data: userSelection[indexPath.row])
            cell.setCornerRadius()
            
            return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCellIdentifier, for: indexPath) as! CollectionViewCardsButtonCell
        }
    }
    
}


extension CollectionViewCardsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let center = CGPoint(x: collectionView.contentOffset.x + collectionView.frame.midX, y: collectionView.frame.midY)
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCardsButtonCell {
                cell.startAnimation()
                
                if let indexPath = collectionView.indexPathForItem(at: center) {
                    delegate?.collectionViewCardsController(cardsController: self, didApproveItemAt: indexPath)
                }
            }
        } else {
            delegate?.collectionViewCardsController(cardsController: self, didSelectItemAt: indexPath)
        }
    }
    
}

