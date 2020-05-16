//
//  CreateStreamViewController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-15.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit
import Firebase

class CreateStreamViewController: UIViewController , CreateStreamInputTextViewDelegate{

    let cellId = "cellId"
    let headerId = "headerId"
    
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
    
    let backButton: CustomImageView = {
        let img = CustomImageView()
        
        img.image = #imageLiteral(resourceName: "down")
                
        return img
    }()
    
    @objc func dismissView() { dismiss(animated: true, completion: nil) }
    
    let currentTime: UILabel = {
        let label = UILabel()
        
        label.textColor = .lightPurple()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        
        return label
    }()
    
    let headerView: UIView = {
        let view = UIView()
                
        return view
    }()
    
    // TextView supports multi-line instead of TextField, but View doesn't have a placeholder attribute
    fileprivate let streamTextView: CreateStreamInputTextView = {
        let textView = CreateStreamInputTextView()
        
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = UIFont(name: "AvenirNext-Regular", size: 14)
                
        return textView
    }()
    
    let submitButton: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.setTitle("SUBMIT STREAM", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        
        btn.backgroundColor = .lightGray
        btn.isEnabled = false
        
        btn.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        
        return btn
    }()
    
    @objc func handleSubmit() {
        guard let post = streamTextView.text else { return }
        guard let uid  = Auth.auth().currentUser?.uid else { return }
        var today = getCurrentDateFormatted()
    
        // When clicking post, disable the button to not spam
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = .lightGray
        submitButton.setTitle("SUBMITTING ...", for: .normal)
        submitButton.isEnabled = false
        
        let userPostRef = Database.database().reference().child("posts").child(uid).child(today)
        
        // Generates new child location using uKey returning Database reference location, good for list of items, aka posts.
        let ref = userPostRef.childByAutoId()
        
        let values = ["stream": post, "time": self.currentTime.text]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.submitButton.setTitleColor(.darkPurple(), for: .normal)
                self.submitButton.backgroundColor = .lightPurple()
                self.submitButton.setTitle("SUBMIT STREAM", for: .normal)
                self.submitButton.isEnabled = true
                print("Failed to save post to DB: ", err)
                return
            }
                
            print("Successfully saved post to DB!")
            
            // Notified app with a specific name to update feed given the name, must add observer in the HomeController
            NotificationCenter.default.post(name: CreateStreamViewController.updateFeedNotificationName, object: nil)
            
            // Succesffully saved, dismiss view
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTime()
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getTime), userInfo: nil, repeats: true)
    }
    
    @objc func getTime() { currentTime.text = getCurrentTimeFormatted() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamTextView.textChangeDelegate = self
        
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
        
        view.addSubview(streamTextView)
        if #available(iOS 11.0, *) {
            streamTextView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: submitButton.topAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 0)
        }
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func textDidChange() {
        guard let textCount = streamTextView.text?.count else { return }
        
        if textCount > 0 {
            submitButton.setTitleColor(.darkPurple(), for: .normal)
            submitButton.backgroundColor = .lightPurple()
            submitButton.isEnabled = true
        } else {
            submitButton.setTitleColor(.white, for: .normal)
            submitButton.backgroundColor = .lightGray
            submitButton.isEnabled = false
        }
    }
}
