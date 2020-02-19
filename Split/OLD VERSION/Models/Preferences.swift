//
//  Preferences.swift
//  Last Four
//
//  Created by David Para on 3/25/18.
//  Copyright © 2018 parad. All rights reserved.
//

import Foundation

public class Preferences {
    
    // MARK: FILEPRIVATE PROPERTIES
    // MARK: Singleton instance
    static fileprivate let _instance = Preferences()
    
    // MARK: Instance properties
    fileprivate var _calculatorType: CalculatorType?
    
    // MARK: INTERNAL PROPERTIES
    // MARK: Instance getter
    static internal var instance: Preferences {
        get { return _instance }
    }
    
    // MARK: Public getters and setters
    internal var calculatorType: CalculatorType {
        get {
            if let type = _calculatorType {
                return type
            } else {
                return .evenSplit
            }
        }
        set {
            _calculatorType = newValue
        }
    }
    
    // MARK: INIT
    // MARK: Singleton pattern
    private init() {}
}
