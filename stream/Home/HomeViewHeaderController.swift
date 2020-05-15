//
//  HomeViewHeaderController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-14.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit

protocol HomeViewHeaderControllerDelegate {
    func didClickCreatePost()
}

class HomeViewHeaderController: UICollectionViewCell {
    
    var delegate: HomeViewHeaderControllerDelegate?
    
    let today: UILabel = {
        let label = UILabel()

        label.text = "Wednesday, September 13, 2020"
        label.textColor = .lightPurple()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        
        return label
    }()
    
    lazy var addButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal), for: .normal)
        
        btn.addTarget(self, action: #selector(clickAddButton), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func clickAddButton() {
        delegate?.didClickCreatePost()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkPurple()
        
        addSubview(today)
        addSubview(addButton)
        
        today.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        today.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        addButton.centerYAnchor.constraint(equalTo: today.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
