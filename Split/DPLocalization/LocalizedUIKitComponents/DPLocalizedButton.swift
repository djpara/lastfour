//
//  UILocalizedButton.swift
//  Split
//
//  Created by David Para on 12/7/18.
//  Copyright © 2018 David Para. All rights reserved.
//

import UIKit

@IBDesignable final class DPLocalizedButton: UIButton {
    
    // MARK: - IBInspectable Properties
    
    @IBInspectable var tableName: String? {
        didSet {
            guard let tableName = tableName else { return }
            let title = self.title(for: .normal)?.localized(fromTable: tableName)
            setTitle(title, for: .normal)
        }
    }

}
