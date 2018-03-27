//
//  UICustomView.swift
//  Last Four
//
//  Created by David Para on 3/26/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class UICustomView: UIView {

    // Storyboard initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = self.borderColor.cgColor
        }
    }
    
}
