//
//  HomeViewCellController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-14.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit

class HomeViewCellController: UICollectionViewCell {
    
    static let reuseId = "MultilineLabelCellReuseId"
    
    let today: UILabel = {
        let label = UILabel()
        
        label.text = "11:59AM"
        label.textColor = .lightPurple()
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        
        return label
    }()
    
    let stream: UILabel = {
        let label = UILabel()
       
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
       
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.addSubview(today)
        contentView.addSubview(stream)
        
        today.translatesAutoresizingMaskIntoConstraints = false
        stream.translatesAutoresizingMaskIntoConstraints = false
        
        today.anchor(top: contentView.layoutMarginsGuide.topAnchor, left: nil, bottom: nil, right: contentView.layoutMarginsGuide.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        stream.anchor(top: today.bottomAnchor, left: contentView.layoutMarginsGuide.leftAnchor, bottom: contentView.layoutMarginsGuide.bottomAnchor, right: contentView.layoutMarginsGuide.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 25, width: 0, height: 0)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        stream.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

