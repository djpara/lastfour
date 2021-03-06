//
//  Brain.swift
//  Last Four
//
//  Created by David Para on 3/28/18.
//  Copyright © 2018 parad. All rights reserved.
//

import Foundation
import UIKit

class Brain {
    
    // MARK: FILEPRIVATE PROPERTIES
    // MARK: Singleton instance
    static fileprivate let _instance = Brain()
    
    // MARK: Instance properties
    fileprivate var _billSum: Double = 0.0
    fileprivate var _tipAmount: Double = 0.0
    fileprivate var _tipPercentage: Double = 0.0 {
        didSet {
            print(_tipPercentage)
        }
    }
    fileprivate var _totalPlayers: Int = 1
    
    // MARK: Instance getter
    static internal var instance: Brain {
        get { return _instance }
    }
    
    // MARK: Instance public getters and setters
    internal var billSum: Double {
        get { return _billSum }
        set { _billSum = newValue }
    }
    
    internal var tipAmount: Double {
        get { return _tipAmount }
        set {
            _tipPercentage = 0.0
            _tipAmount = newValue
        }
    }
    
    internal var tipPercentage: Double {
        get { return _tipPercentage }
        set {
            _tipPercentage = newValue
            _tipAmount = _billSum*_tipPercentage
            _tipPercentage = 0.0
        }
    }
    
    internal var totalPlayers: Int {
        get { return _totalPlayers }
        set { _totalPlayers = newValue }
    }
    
    // MARK: INIT
    // MARK: Singleton pattern
    private init() {}
    
    // MARK: FILEPRIVATE FUNCTIONS
    fileprivate func getTipUsingAmount() -> Double {
        return tipAmount
    }
    
    fileprivate func getTipUsingPercentage() -> Double {
        return billSum * tipPercentage
    }
    
    // MARK: INTERNAL FUNCTIONS
    internal func getTipAmount() -> String {
        return _tipAmount > _tipPercentage ? getTipUsingAmount().toDollarFormat() : getTipUsingPercentage().toDollarFormat()
    }
    
    internal func getTotal() -> String {
        return ((_tipAmount+_billSum)/Double(_totalPlayers)).toDollarFormat()
    }
    
    internal func clear() {
        _billSum        = 0.0
        _tipAmount      = 0.0
        _tipPercentage  = 0.0
        _totalPlayers   = 1
    }
}
