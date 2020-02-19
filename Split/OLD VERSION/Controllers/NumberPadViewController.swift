//
//  NumberPadViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class NumberPadViewController: UIViewController {
    
    // MARK: FILEPRIVATE CONSTANTS
    
    fileprivate final let DONE_TITLE = "Done"
    fileprivate final let ADD_ITEM_TITLE = "Add Item"
    
    // MARK: FILEPRIVATE PROPERTIES
    
    fileprivate var _numberPadDelegate: NumberPadDelegate?
    
    fileprivate var _calculatorType: CalculatorType = .evenSplit
    
    fileprivate var _isDoneSwitch = false
    
    // MARK: INTERNAL PROPERTIES
    
    internal var numberPadDelegate: NumberPadDelegate? {
        get { return _numberPadDelegate }
        set { _numberPadDelegate = newValue }
    }
    
    // MARK: IBOUTLET PROPERTIES
    
    @IBOutlet var evenSplitButtons: [UICustomButton]!
    @IBOutlet var itemizedSplitButtons: [UICustomButton]!
    @IBOutlet var utilityButtons: [UICustomButton]!
    
    @IBOutlet weak var addItemButton: UICustomButton!
    
    // MARK: OVERRIDE FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalc()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        print("Number Pad Controller deinitialized")
    }
    
    // MARK: IBACTION FUNCTIONS
    
    @IBAction func removeLastPressed(_ sender: Any) {
        if _isDoneSwitch {
            addItemButton.setTitle(ADD_ITEM_TITLE, for: .normal)
            _isDoneSwitch = false
        }
        
        numberPadDelegate?.removeLast()
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        if _isDoneSwitch {
            addItemButton.setTitle(ADD_ITEM_TITLE, for: .normal)
            _isDoneSwitch = false
        }
        
        numberPadDelegate?.close()
    }
    
    @IBAction func clearPressed(_ sender: Any) {
        if _isDoneSwitch {
            addItemButton.setTitle(ADD_ITEM_TITLE, for: .normal)
            _isDoneSwitch = false
        }
        
        numberPadDelegate?.clear()
    }
    
    @IBAction func addItemPressed(_ sender: Any) {
        if _isDoneSwitch {
            cancelPressed(sender)
            return
        }
        
        addItemButton.setTitle(DONE_TITLE, for: .normal)
        _isDoneSwitch = true
        numberPadDelegate?.addItem()
    }
    
    @IBAction func enterPressed(_ sender: Any) {
        if _isDoneSwitch {
            addItemButton.setTitle(ADD_ITEM_TITLE, for: .normal)
            _isDoneSwitch = false
        }
        
        numberPadDelegate?.enter()
    }
    
    @IBAction func numericPressed(_ sender: UICustomButton) {
        if _isDoneSwitch {
            addItemButton.setTitle(ADD_ITEM_TITLE, for: .normal)
            _isDoneSwitch = false
        }
        
        numberPadDelegate?.insertKey("\(sender.tag)")
    }
    
    @IBAction func doubleZeroPressed(_ sender: UICustomButton) {
        if _isDoneSwitch {
            addItemButton.setTitle(ADD_ITEM_TITLE, for: .normal)
            _isDoneSwitch = false
        }
        
        numberPadDelegate?.insertKey("00")
    }
    
    @IBAction func decimalPressed(_ sender: UICustomButton) {
        if _isDoneSwitch {
            addItemButton.setTitle(ADD_ITEM_TITLE, for: .normal)
            _isDoneSwitch = false
        }
        
        numberPadDelegate?.insertKey(".")
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    
    fileprivate func configureCalc() {
        switch _calculatorType {
        case .evenSplit:
            showEvenSplitButtons()
        case .itemizedSplit:
            showItemizedSplitButtons()
        case .simpleTip:
            showEvenSplitButtons()
        }
        
        utilityButtons.forEach { button in
            button.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    fileprivate func showEvenSplitButtons() {
        Array(Set(evenSplitButtons).symmetricDifference(utilityButtons)).forEach { button in
            button.hide()
        }
    }
    
    fileprivate func showItemizedSplitButtons() {
        Array(Set(itemizedSplitButtons).symmetricDifference(utilityButtons)).forEach { button in
            button.hide()
        }
    }
    
    // MARK: INTERNAL FUNCTIONS
    
    internal func setType(_ type: CalculatorType) {
        _calculatorType = type
    }
}
