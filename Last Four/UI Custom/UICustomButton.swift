//
//  UICustomButton.swift
//  Last Four
//
//  Created by David Para on 3/21/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

@IBDesignable
class UICustomButton: UIButton {
    
    // Storyboard initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        updateAlpha()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateAlpha()
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat = 8.0 {
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
    
    // Sets isEnabled to true and 'un-grays' the visual effect
    func enable() {
        isEnabled = true
        updateAlpha()
    }
    
    // Sets isEnabled to false and provides 'gray-out' visual effect
    func disable() {
        isEnabled = false
        updateAlpha()
    }
    
    // Hides the button
    func hide() {
        isHidden = true
    }
    
    // Unhides the button
    func show() {
        isHidden = false
    }
    
    // Gives the "grayed out" feel
    private func updateAlpha() {
        if isEnabled {
            alpha = 1.0
        } else {
            alpha = 0.5
        }
    }
    
    // Gives the "grayed out/pressed" feel when pressing button
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        alpha = 0.5
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        alpha = 1.0
        super.touchesEnded(touches, with: event)
    }
    
}
