//
//  ListViewCellController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-15.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit

class ListViewCellController: UICollectionViewCell {
    
    static let reuseId = "MultilineLabelCellReuseId"
    
    let date: UILabel = {
        let label = UILabel()
        
        label.text = "Saturday, May 9, 2020"
        label.textColor = .lightPurple()
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        
        return label
    }()
    
    let nextArrow: CustomImageView = {
        let img = CustomImageView()
        
        img.image = #imageLiteral(resourceName: "next")
        
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(date)
        addSubview(nextArrow)
        
        date.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        date.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        nextArrow.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        nextArrow.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

