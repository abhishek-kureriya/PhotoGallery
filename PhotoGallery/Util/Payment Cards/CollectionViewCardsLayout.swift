//
// CollectionViewCardsLayout.swift
//  Created by Abhishek kureriya on 20/04/2018.
//

import UIKit

class CollectionViewCardsLayout: UICollectionViewLayout {
    
    enum InvalidationState {
        case everything
        case scroll
        case unknown
        
        init(_ invalidationContext: UICollectionViewLayoutInvalidationContext) {
            if invalidationContext.invalidateEverything || invalidationContext.invalidateDataSourceCounts {
                self = .everything
            } else if let context = invalidationContext as? InvalidationContext {
                if context.invalidateScroll {
                    self = .scroll
                } else {
                    self = .unknown
                }
            } else {
                self = .unknown
            }
        }
    }
    
    class InvalidationContext: UICollectionViewLayoutInvalidationContext {
        var invalidateScroll: Bool = false
    }
    
    let cellSpacing: CGFloat = 8
    let buttonWidth: CGFloat = 110
    let buttonHeight: CGFloat = 50
    let itemInsets = UIEdgeInsets(top: 0, left: 8, bottom: 50, right: 8)
    let sectionInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    private var invalidationState: InvalidationState = .everything
    private var originalLayoutAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private var layoutAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private var buttonLayoutAttributes: UICollectionViewLayoutAttributes? = nil
    private var contentSize: CGSize = .zero
    private var removedItems: [IndexPath: UICollectionViewUpdateItem] = [:]
    private var insertedItems: [IndexPath: UICollectionViewUpdateItem] = [:]
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override open func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        switch (InvalidationState(context), invalidationState) {
        case (.everything, _), (_, .everything):
            invalidationState = .everything
        case (.scroll, _), (_, .scroll):
            invalidationState = .scroll
        default:
            invalidationState = .unknown
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let context = InvalidationContext()
        context.invalidateScroll = true
        invalidateLayout(with: context)
        return false
    }
    
    override func prepare() {
        super.prepare()
        switch invalidationState {
        case .everything:
            layoutAttributes = [:]
            originalLayoutAttributes = [:]
            createLayoutAttributes()
            createButtonLayoutAttributes()
            offsetLayoutAttributes()
        case .scroll:
            offsetLayoutAttributes()
            createButtonLayoutAttributes()
        case .unknown:
            break
        }
        
        invalidationState = .unknown
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        for item in updateItems {
            if let indexPath = item.indexPathBeforeUpdate, item.updateAction == .delete {
                removedItems[indexPath] = item
            } else if let indexPath = item.indexPathAfterUpdate, item.updateAction == .insert {
                insertedItems[indexPath] = item
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        self.removedItems = [:]
        self.insertedItems = [:]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = Array(layoutAttributes.values)
        
        if let buttonLayoutAttributes = buttonLayoutAttributes {
            attributes.append(buttonLayoutAttributes)
        }
        
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch indexPath.section {
        case 0:
            return layoutAttributes[indexPath]
        default:
            return buttonLayoutAttributes
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        if layoutAttributes.count <= 1 {
            return .zero
        } else {
            return CGPoint(x: proposedContentOffset.x - 0.001, y: proposedContentOffset.y)
        }
    }
    
    private func createButtonLayoutAttributes() {
        guard let collectionView = collectionView else { return }
        
        if collectionView.numberOfSections > 1 {
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 0, section: 1))
            var x: CGFloat = collectionView.contentOffset.x + (collectionView.frame.width / 2) - (buttonWidth / 2)
            
            if collectionView.contentOffset.x < 0 {
                x = (collectionView.frame.width / 2) - (buttonWidth / 2)
            } else if contentSize.width > collectionView.frame.width && collectionView.contentOffset.x + collectionView.frame.width > contentSize.width {
                x = collectionView.contentSize.width - (collectionView.frame.width / 2) - (buttonWidth / 2)
            }
            
            attributes.zIndex = 10
            attributes.frame = CGRect(
                x: x,
                y: collectionView.bounds.height - (buttonHeight / 2) - itemInsets.bottom,
                width: buttonWidth,
                height: buttonHeight)
            
            buttonLayoutAttributes = attributes
        } else {
            buttonLayoutAttributes = nil
        }
    }
    
    private func offsetLayoutAttributes() {
        guard let collectionView = collectionView else { return }
        
        for attributes in originalLayoutAttributes.values {
            let inset: CGFloat = itemInsets.left + sectionInsets.left
            let progress = collectionView.contentOffset.x / collectionView.frame.width
            layoutAttributes[attributes.indexPath]?.frame = attributes.frame.offsetBy(dx: inset * progress, dy: 0)
        }
    }
    
    private func createLayoutAttributes() {
        guard let collectionView = collectionView else { return }
        
        var layoutAttributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
        var previousFrame: CGRect = .zero
        previousFrame.origin.x = sectionInsets.left - cellSpacing
        
        for index in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.frame = CGRect(
                x: previousFrame.maxX + cellSpacing,
                y: itemInsets.top,
                width: collectionView.frame.width - (cellSpacing * 2) - itemInsets.left - itemInsets.right,
                height: collectionView.bounds.height - itemInsets.top - itemInsets.bottom)
            
            previousFrame = attributes.frame
            layoutAttributes[indexPath] = attributes
        }
        
        contentSize = CGSize(
            width: previousFrame.maxX + itemInsets.right + itemInsets.left + (CGFloat(layoutAttributes.count - 1) * (sectionInsets.left + itemInsets.left)),
            height: collectionView.bounds.height)
        
        self.layoutAttributes = layoutAttributes
        
        for (indexPath, attributes) in layoutAttributes {
            originalLayoutAttributes[indexPath] = attributes.copy() as? UICollectionViewLayoutAttributes
        }
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { return nil }
        
        switch itemIndexPath.section {
        case 0:
            if removedItems[itemIndexPath]?.updateAction == .delete {
                let attributes = UICollectionViewLayoutAttributes(forCellWith: itemIndexPath)
                var transform = CATransform3DIdentity
                transform = CATransform3DTranslate(transform, 0, 0, -1)
                transform = CATransform3DScale(transform, 0.2, 0.2, 0.2)
                
                attributes.alpha = 0
                attributes.transform3D = transform
                attributes.frame = CGRect(
                    x: collectionView.contentOffset.x + cellSpacing + itemInsets.left,
                    y: itemInsets.top,
                    width: collectionView.frame.width - (cellSpacing * 2) - itemInsets.left - itemInsets.right,
                    height: collectionView.bounds.height - itemInsets.top - itemInsets.bottom)
                
                return attributes
            }
        default:
            if layoutAttributes.isEmpty {
                let attributes = UICollectionViewLayoutAttributes(forCellWith: itemIndexPath)
                var transform = CATransform3DIdentity
                transform = CATransform3DTranslate(transform, 0, -buttonHeight, 0)
                transform = CATransform3DScale(transform, 0.2, 0.2, 0.2)
                
                attributes.alpha = 0
                attributes.transform3D = transform
                attributes.frame = CGRect(
                    x: collectionView.contentOffset.x + (collectionView.frame.width / 2) - (buttonWidth / 2),
                    y: collectionView.bounds.height - buttonHeight,
                    width: buttonWidth,
                    height: buttonHeight)
                
                return attributes
            }
        }
        return super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
    }
}

