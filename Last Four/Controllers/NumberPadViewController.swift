//
//  NumberPadViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class NumberPadViewController: UIViewController {
    
    // MARK: FILEPRIVATE PROPERTIES
    fileprivate var _numberPadDelegate: NumberPadDelegate?
    
    fileprivate var _calculatorType: CalculatorType = .evenSplit
    
    // MARK: INTERNAL PROPERTIES
    internal var numberPadDelegate: NumberPadDelegate? {
        get { return _numberPadDelegate }
        set { _numberPadDelegate = newValue }
    }
    
    // MARK: IBOUTLET PROPERTIES
    @IBOutlet var evenSplitButtons: [UICustomButton]!
    @IBOutlet var itemizedSplitButtons: [UICustomButton]!
    @IBOutlet var utilityButtons: [UICustomButton]!
    
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalc()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: IBACTION FUNCTIONS
    @IBAction func removeLastPressed(_ sender: Any) {
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        numberPadDelegate?.close()
    }
    
    @IBAction func addItemPressed(_ sender: Any) {
    }
    
    @IBAction func enterPressed(_ sender: Any) {
        numberPadDelegate?.enter()
        numberPadDelegate?.close()
    }
    
    @IBAction func numericPressed(_ sender: UICustomButton) {
        numberPadDelegate?.insertKey("\(sender.tag)")
    }
    
    @IBAction func doubleZeroPressed(_ sender: UICustomButton) {
        numberPadDelegate?.insertKey("00")
    }
    
    @IBAction func decimalPressed(_ sender: UICustomButton) {
        numberPadDelegate?.insertKey(".")
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    fileprivate func configureCalc() {
        switch _calculatorType {
        case .evenSplit:
            showEvenSplitButtons()
        case .itemizedSplit:
            showItemizedSplitButtons()
        }
    }
    
    fileprivate func showEvenSplitButtons() {
        Array(Set(evenSplitButtons).symmetricDifference(utilityButtons)).forEach { button in
            button.layer.opacity = 0.0
        }
    }
    
    fileprivate func showItemizedSplitButtons() {
        Array(Set(itemizedSplitButtons).symmetricDifference(utilityButtons)).forEach { button in
            button.layer.opacity = 0.0
        }
    }
    
    // MARK: INTERNAL FUNCTIONS
    internal func setType(_ type: CalculatorType) {
        _calculatorType = type
    }
}
