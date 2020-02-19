//
//  UILocalizedTextField.swift
//  Split
//
//  Created by David Para on 12/7/18.
//  Copyright © 2018 David Para. All rights reserved.
//

import UIKit

@IBDesignable final class DPLocalizedTextField: UITextField {
    
    // MARK: - IBInspectable Properties
    
    @IBInspectable var tableName: String? {
        didSet {
            guard let tableName = tableName else { return }
            text = text?.localized(fromTable: tableName)
        }
    }
    
}
