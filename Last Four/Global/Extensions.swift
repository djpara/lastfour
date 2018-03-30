//
//  Extensions.swift
//  Last Four
//
//  Created by David Para on 3/29/18.
//  Copyright © 2018 parad. All rights reserved.
//

import Foundation

// MARK: Double Extension
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
