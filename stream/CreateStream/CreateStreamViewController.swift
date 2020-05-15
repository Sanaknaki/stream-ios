//
//  CreateStreamViewController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-15.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit
import Firebase

class CreateStreamViewController: UIViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    let backButton: CustomImageView = {
        let img = CustomImageView()
        
        img.image = #imageLiteral(resourceName: "down")
                
        return img
    }()
    
    @objc func dismissView() { dismiss(animated: true, completion: nil) }
    
    let currentTime: UILabel = {
        let label = UILabel()
        
        label.text = "5:42PM"
        label.textColor = .lightPurple()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        
        return label
    }()
    
    let headerView: UIView = {
        let view = UIView()
                
        return view
    }()
    
    // TextView supports multi-line instead of TextField, but View doesn't have a placeholder attribute
    fileprivate let commentTextView: CreateStreamInputTextView = {
        let textView = CreateStreamInputTextView()
        
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        
        textView.font = UIFont(name: "AvenirNext-Regular", size: 14)
        
        return textView
    }()
    
    let submitButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("SUBMIT STREAM", for: .normal)
        btn.setTitleColor(.darkPurple(), for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        
        btn.backgroundColor = .lightPurple()
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkPurple()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backButton.addGestureRecognizer(tap)
        backButton.isUserInteractionEnabled = true
        
        setupNavigationBar()
    }
    
    fileprivate func setupNavigationBar() {
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        
        
        headerView.addSubview(backButton)
        backButton.anchor(top: nil, left: nil, bottom: nil, right: headerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        headerView.addSubview(currentTime)
        currentTime.anchor(top: nil, left: headerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        currentTime.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        view.addSubview(submitButton)
        submitButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        view.addSubview(commentTextView)
        if #available(iOS 11.0, *) {
            commentTextView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: submitButton.topAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 0)
        }
        
        navigationController?.isNavigationBarHidden = true
    }
}
