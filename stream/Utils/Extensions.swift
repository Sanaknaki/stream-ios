//
//  Extensions.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-13.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Simplify creating RGB colours
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func darkPurple() -> UIColor {
        return UIColor.rgb(red: 74, green: 54, blue: 139)
    }
    
    static func lightPurple() -> UIColor {
        return UIColor.rgb(red: 123, green: 102, blue: 194)
    }
}

extension UIView {
    
    // Anchoring is crazy, this is a lot to take in.
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top { self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true }
        if let left = left { self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true }
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true }
        if let right = right { self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true }
        if width != 0 { widthAnchor.constraint(equalToConstant: width).isActive = true }
        if height != 0 { heightAnchor.constraint(equalToConstant: height).isActive = true }
    }
}

extension Date {
    
    func howManyDaysHasItBeen() -> Int {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        
        if (secondsAgo < minute || secondsAgo < hour || secondsAgo < day) {
            return 0
        } else {
            let quotient = secondsAgo / day
            return quotient
        }
    }
    
    func timeAgoDisplay(userDate: Bool) -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day

        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "s"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "m"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "h"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "d"
        } else {
            quotient = secondsAgo / week
            unit = "w"
        }

        if(unit == "yesterday") {
            return unit
        }
        
        return "\(quotient)\(unit)"
        
//        if(userDate) {
//            return "\(quotient)\(unit)"
//        } else {
//            return "\(quotient)\(unit) ago"
//        }
        
    }
}
