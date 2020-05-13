//
//  SignUpViewController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-13.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    let logo: CustomImageView = {
        let img = CustomImageView()
        
        img.image = #imageLiteral(resourceName: "icon-logo").withRenderingMode(.alwaysOriginal)
        
        return img
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        
        tf.attributedPlaceholder = NSMutableAttributedString(string: "Click to enter username", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        
        tf.attributedPlaceholder = NSMutableAttributedString(string: "Click to enter email", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        
        tf.attributedPlaceholder = NSMutableAttributedString(string: "Click to enter password", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return tf
    }()
    
    let secondPasswordTextField: UITextField = {
        let tf = UITextField()
        
        tf.attributedPlaceholder = NSMutableAttributedString(string: "Click to re-enter password", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return tf
    }()
    
    let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("SIGN UP", for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 25
        

        btn.backgroundColor = .clear
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        
        return btn
    }()
    
    let signIntoExistingAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("Sign into your existing account", for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 15)
        btn.setTitleColor(.lightPurple(), for: .normal)
        
        btn.addTarget(self, action: #selector(clickedSignIntoExistingAccount), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func clickedSignIntoExistingAccount() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkPurple()

        view.addSubview(logo)
        view.addSubview(signIntoExistingAccountButton)
        view.addSubview(signUpButton)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        
        logo.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 200, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 25)
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        signIntoExistingAccountButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 40, paddingRight: 0, width: 0, height: 0)
        signIntoExistingAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: signIntoExistingAccountButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 25, paddingRight: 25, width: 0, height: 50)
        
        setupInputFields()

        setupNavigationBar()
    }

    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, emailTextField, passwordTextField, secondPasswordTextField])
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
                
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: signUpButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 45, paddingRight: 25, width: 0, height: 340)
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
}

