//
//  PaymentCardsButtonCell.swift
//  NMB
//
//  Created by Martin Rechsteiner on 21/02/2018.
//  Copyright © 2018 DNB. All rights reserved.
//

import UIKit

class PaymentCardsButtonCell: UICollectionViewCell {
    
    private let titleLabel: UILabel
    private let lineLayer: CAShapeLayer
    private var path: UIBezierPath? = nil
    
    override init(frame: CGRect) {
        titleLabel = UILabel()
        lineLayer = CAShapeLayer()
        
        super.init(frame: frame)
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        titleLabel.text = "Remove"
        
        lineLayer.lineWidth = 2
        lineLayer.opacity = 0
        lineLayer.lineCap = kCALineCapRound
        lineLayer.fillColor = nil
        lineLayer.strokeColor = UIColor.white.cgColor
        
        contentView.layer.shadowColor = UIColor(red: 0/255, green: 132/255, blue: 132/255, alpha: 0.24).cgColor
        contentView.layer.shadowRadius = 12
        contentView.layer.shadowOffset = CGSize(width: 0, height: 8)
        contentView.layer.shadowOpacity = 1
        contentView.backgroundColor = UIColor(red: 0, green: 132/255, blue: 132/255, alpha: 1)
        contentView.addSubview(titleLabel)
        contentView.layer.addSublayer(lineLayer)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.midY
        
        let rect = contentView.bounds.insetBy(dx: 1, dy: 1)
        path = UIBezierPath(roundedRect: rect, cornerRadius: contentView.frame.midY)
        lineLayer.path = path?.cgPath
        lineLayer.strokeStart = 1
        lineLayer.strokeEnd = 1
    }
    
    func stopAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
            self.titleLabel.alpha = 1
            self.lineLayer.opacity = 0
        }, completion: { _ in
            self.lineLayer.removeAllAnimations()
        })
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.lineLayer.opacity = 1
            self.titleLabel.alpha = 0
        }
        let duration = TimeInterval(2)
        
        let strokeEndAnimation: CAAnimation = {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = duration * 0.7
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            let group = CAAnimationGroup()
            group.duration = duration
            group.repeatCount = Float.infinity
            group.animations = [animation]
            group.isRemovedOnCompletion = false
            
            return group
        }()
        
        let strokeStartAnimation: CAAnimation = {
            let animation = CABasicAnimation(keyPath: "strokeStart")
            animation.beginTime = duration * 0.1
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = duration * 0.9
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            let group = CAAnimationGroup()
            group.duration = duration
            group.repeatCount = Float.infinity
            group.animations = [animation]
            group.isRemovedOnCompletion = false
            
            return group
        }()
        
        lineLayer.removeAllAnimations()
        lineLayer.add(strokeEndAnimation, forKey: "strokeEnd")
        lineLayer.add(strokeStartAnimation, forKey: "strokeStart")
    }
}

