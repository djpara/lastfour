//
//  Extensions.swift
//  Last Four
//
//  Created by David Para on 3/29/18.
//  Copyright © 2018 parad. All rights reserved.
//

import Foundation
import UIKit

// MARK: Double Extension
extension Double {
    func toDollarFormat() -> String {
        
        let decDelimited = String(self).split(separator: ".")
        
        if decDelimited[1].count == 2 {
            return "\(self)"
        } else if decDelimited[1].count > 2 {
            // Recursive call ensures that it adds another zero if necessary
            return ((100.0 * self).rounded() / 100.0).toDollarFormat()
        }
        
        return "\(self)0"
        
    }
}

// MARK: UIView Extension
extension UIView {
    func fadeOut(duration: Double, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.layer.opacity = 0.0
        }, completion: completion)
    }
    
    func fadeIn(duration: Double, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.layer.opacity = 1.0
        }, completion: completion)
    }
}
