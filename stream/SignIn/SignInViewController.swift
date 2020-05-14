//
//  ViewController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-13.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    let logo: CustomImageView = {
        let img = CustomImageView()
        
        img.image = #imageLiteral(resourceName: "icon-logo").withRenderingMode(.alwaysOriginal)
        
        return img
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        
        tf.textColor = .white
        
        tf.font = UIFont(name: "AvenirNext-Regular", size: 14)
        tf.attributedPlaceholder = NSMutableAttributedString(string: "Click to enter email", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        
        tf.textColor = .white
        tf.isSecureTextEntry = true
        
        tf.font = UIFont(name: "AvenirNext-Regular", size: 14)
        tf.attributedPlaceholder = NSMutableAttributedString(string: "Click to enter password", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let signInButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("SIGN IN", for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18)
        btn.setTitleColor(.lightPurple(), for: .normal)
        btn.layer.cornerRadius = 25
        

        btn.backgroundColor = .clear
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightPurple().cgColor
        
        btn.isEnabled = false
        
        btn.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func handleSignIn() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email.lowercased(), password: password) { (user: AuthDataResult?, err: Error?) in
            if let err = err {
                print("Failed to perform login : ", err)
                self.errorMessage.attributedText = NSMutableAttributedString(string: err.localizedDescription, attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.danger()])
                self.errorMessage.isHidden = false
                return
            }
            
            print("Successfully logged in to account : ", user?.user.uid)
            
            // Object that represents entire app, shared gets the app, keyWindow is the window that you see in the app
            // RootView = MainTabBarController that was set in AppDelegate
            guard let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarController else { return }
            
            tabBarController.setupViewControllers()
            
            // Gets rid of the login view and shows you as logged in
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    let createNewAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("Create a new account", for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 15)
        btn.setTitleColor(.lightPurple(), for: .normal)
        
        btn.addTarget(self, action: #selector(clickCreateNewAccount), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func clickCreateNewAccount() {
        let signUpViewController = SignUpViewController()
        
        navigationController?.pushViewController(signUpViewController, animated: true)
    }

    let errorMessage: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.textColor = .danger()
        label.font = UIFont(name: "AvenirNext-Regular", size: 13)
        label.isHidden = true
        
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
        
        signInButton.setTitleColor(.lightPurple(), for: .normal)
        signInButton.layer.borderColor = UIColor.lightPurple().cgColor
        signInButton.isEnabled = false
        
        errorMessage.text = ""
        errorMessage.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkPurple()

        view.addSubview(logo)
        view.addSubview(createNewAccountButton)
        view.addSubview(signInButton)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(errorMessage)
        
        logo.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 200, paddingLeft: 130, paddingBottom: 0, paddingRight: 130, width: 0, height: 35)
        
        createNewAccountButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 40, paddingRight: 0, width: 0, height: 0)
        createNewAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        signInButton.anchor(top: nil, left: view.leftAnchor, bottom: createNewAccountButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 25, paddingRight: 25, width: 0, height: 50)
        
        setupInputFields()
        
        errorMessage.anchor(top: nil, left: view.leftAnchor, bottom: signInButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 15, paddingRight: 25, width: 0, height: 0)
        errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupNavigationBar()
    }

    // Handle disabling/enabling of login button
    @objc func handleTextInputChange() {
        let isSignUpFormValid = emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        
        if isSignUpFormValid {
            signInButton.setTitleColor(.white, for: .normal)
            signInButton.layer.borderColor = UIColor.white.cgColor
            signInButton.isEnabled = true
        } else {
            signInButton.setTitleColor(.lightPurple(), for: .normal)
            signInButton.layer.borderColor = UIColor.lightPurple().cgColor
            signInButton.isEnabled = false
        }
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
                
        view.addSubview(stackView)
        stackView.anchor(top: nil, left: view.leftAnchor, bottom: signInButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 45, paddingRight: 25, width: 0, height: 160)
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
}

