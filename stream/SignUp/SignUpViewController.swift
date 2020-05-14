//
//  SignUpViewController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-13.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    let logo: CustomImageView = {
        let img = CustomImageView()
        
        img.image = #imageLiteral(resourceName: "icon-logo").withRenderingMode(.alwaysOriginal)
        
        return img
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        
        tf.textColor = .white
        
        tf.font = UIFont(name: "AvenirNext-Regular", size: 14)
        tf.attributedPlaceholder = NSMutableAttributedString(string: "Click to enter username", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
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
    
    let secondPasswordTextField: UITextField = {
        let tf = UITextField()
        
        tf.textColor = .white
        tf.isSecureTextEntry = true
        
        tf.font = UIFont(name: "AvenirNext-Regular", size: 14)
        tf.attributedPlaceholder = NSMutableAttributedString(string: "Click to re-enter password", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("SIGN UP", for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 18)
        btn.setTitleColor(.lightPurple(), for: .normal)
        btn.layer.cornerRadius = 25
        

        btn.backgroundColor = .clear
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightPurple().cgColor
        
        btn.isEnabled = false
        
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func handleSignUp() {
        guard let username = usernameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let repassword = secondPasswordTextField.text else { return }
        
        errorMessage.isHidden = true
        
        if(username.contains(" ")) {
            self.errorMessage.attributedText = NSMutableAttributedString(string: "No spaces in username!", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.danger()])
            self.errorMessage.isHidden = false
        } else if (username.count > 24 || username.count < 3) {
            self.errorMessage.attributedText = NSMutableAttributedString(string: "Username must be between 3 and 24 characters!", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.danger()])
            self.errorMessage.isHidden = false
        } else if(password != repassword) {
            self.errorMessage.attributedText = NSMutableAttributedString(string: "Passwords do not match!", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.danger()])
            self.errorMessage.isHidden = false
        } else {
            Auth.auth().createUser(withEmail: email.lowercased(), password: password, completion: { (user: AuthDataResult?, error: Error?) in
                if let err = error {
                    print("Failed to create user: ", err)
                    self.errorMessage.attributedText = NSMutableAttributedString(string: err.localizedDescription, attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Regular", size: 14), NSAttributedString.Key.foregroundColor: UIColor.danger()])
                    self.errorMessage.isHidden = false
                    return
                }
                
                print("Successfully created user: ", user?.user.uid ?? "")
                
                guard let uid = user?.user.uid else { return }
                
                let dictValues = ["username": username.lowercased(), "joined_date": Date().timeIntervalSince1970] as [String: Any]
                
                // Tree is {users: {uid: {username : username, profileImageUrl: url}}}
                let values = [uid: dictValues]
                
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let err = err {
                        print("Failed to save user info into DB: ", err)
                        return
                    }

                    print("Successfully saved user info to DB!")
                    
                    // Object that represents entire app, shared gets the app, keyWindow is the window that you see in the app
                    // RootView = MainTabBarController that was set in AppDelegate
                    guard let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarController else { return }
                    
                    tabBarController.setupViewControllers()
                    
                    // Gets rid of the login view and shows you as logged in
                    self.dismiss(animated: true, completion: nil)
                })
            })
        }
    }
    
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
        usernameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        secondPasswordTextField.text = ""
        
        signUpButton.setTitleColor(.lightPurple(), for: .normal)
        signUpButton.layer.borderColor = UIColor.lightPurple().cgColor
        signUpButton.isEnabled = false
        
        errorMessage.text = ""
        errorMessage.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkPurple()

        view.addSubview(logo)
        view.addSubview(signIntoExistingAccountButton)
        view.addSubview(signUpButton)
        view.addSubview(errorMessage)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        
        logo.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 200, paddingLeft: 130, paddingBottom: 0, paddingRight: 130, width: 0, height: 35)
    
        signIntoExistingAccountButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 40, paddingRight: 0, width: 0, height: 0)
        signIntoExistingAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: signIntoExistingAccountButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 25, paddingRight: 25, width: 0, height: 50)
        
        setupInputFields()

        errorMessage.anchor(top: nil, left: view.leftAnchor, bottom: signUpButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 15, paddingRight: 25, width: 0, height: 0)
        errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupNavigationBar()
    }

    // Handle disabling/enabling of login button
    @objc func handleTextInputChange() {
        let isSignUpFormValid = usernameTextField.text?.count ?? 0 > 0 && emailTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0 && secondPasswordTextField.text?.count ?? 0 > 0
        
        if isSignUpFormValid {
            signUpButton.setTitleColor(.white, for: .normal)
            signUpButton.layer.borderColor = UIColor.white.cgColor
            signUpButton.isEnabled = true
        } else {
            signUpButton.setTitleColor(.lightPurple(), for: .normal)
            signUpButton.layer.borderColor = UIColor.lightPurple().cgColor
            signUpButton.isEnabled = false
        }
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

