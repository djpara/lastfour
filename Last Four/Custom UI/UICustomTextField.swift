//
//  UICustomTextField.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

@IBDesignable
class UICustomTextField: UITextField {
    
    // Storyboard initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable
    public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    
    @IBInspectable
    public var cornerRadius: CGFloat = 8.0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }
}
