//
//  CustomButton.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    override func awakeFromNib() {

        self.titleLabel!.lineBreakMode = .byWordWrapping
        self.titleLabel!.textAlignment = .center
    }
    public func setCustomTitle(title: String,subtitle: String) {

        let substring1: NSString = title as NSString
        
        let substring2: NSString = "\n\(subtitle as NSString)" as NSString

        let attributeString = NSMutableAttributedString(string: substring1 as String, attributes:[NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14.0), NSForegroundColorAttributeName: UIColor.black])
        
        let attributeString1 = NSMutableAttributedString(string: substring2 as String, attributes:[NSFontAttributeName : UIFont.systemFont(ofSize: 10.0),NSForegroundColorAttributeName: UIColor.gray])
        attributeString.append(attributeString1);
        self.setAttributedTitle(attributeString, for: .normal)
        
    }
}
