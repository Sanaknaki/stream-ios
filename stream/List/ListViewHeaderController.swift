//
//  ListViewHeaderController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-15.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit

protocol ListViewHeaderControllerDelegate {
    func didClickSignOut()
}

class ListViewHeaderController: UICollectionViewCell {
    
    var delegate: ListViewHeaderControllerDelegate?
    
    let logOut: UILabel = {
        let label = UILabel()

        label.text = "Sign Out"
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
                
        return label
    }()

    @objc func handleLogOut() { delegate?.didClickSignOut() }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkPurple()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleLogOut))
        logOut.addGestureRecognizer(tap)
        logOut.isUserInteractionEnabled = true
        
        addSubview(logOut)
        logOut.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        logOut.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
