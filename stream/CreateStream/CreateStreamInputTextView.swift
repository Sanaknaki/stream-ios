//
//  CreateStreamInputTextView.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-15.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit

class CreateStreamInputTextView: UITextView {
    
    fileprivate let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Click to type your stream of thought."
        
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Regular", size: 14)
        
        return label
    }()
    
    func showPlaceholderLabel() { placeholderLabel.isHidden = false }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        // This detects when change is made, will be used to hide placeholder label when there's text
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // If there's text, hide placeholder. else show
    @objc func handleTextChange() { placeholderLabel.isHidden = !self.text.isEmpty }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

