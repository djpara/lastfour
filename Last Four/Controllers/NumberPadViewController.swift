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
    
    fileprivate var _currentFigure: String = ""
    
    fileprivate var _figurePassedMaxCheck: Bool {
        get { return _currentFigure.count <= 10 }
    }
    
    fileprivate var _figureContainsDecimal: Bool {
        get { return _currentFigure.contains(".") }
    }
    
    // MARK: INTERNAL PROPERTIES
    internal var numberPadDelegate: NumberPadDelegate? {
        get { return _numberPadDelegate }
        set { _numberPadDelegate = newValue }
    }
    
    // MARK: IBOUTLET PROPERTIES
    @IBOutlet var evenSplitButtons: [UICustomButton]!
    @IBOutlet var itemizedSplitButtons: [UICustomButton]!
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: IBACTION FUNCTIONS
    @IBAction func removeLastPressed(_ sender: Any) {
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addItemPressed(_ sender: Any) {
    }
    
    @IBAction func enterPressed(_ sender: Any) {
    }
    
    @IBAction func numericPressed(_ sender: UICustomButton) {
        guard _figurePassedMaxCheck else { return }
        numberPadDelegate?.insertKey("\(sender.tag)")
    }
    
    @IBAction func doubleZeroPressed(_ sender: UICustomButton) {
        guard _figurePassedMaxCheck else { return }
        numberPadDelegate?.insertKey("00")
    }
    
    @IBAction func decimalPressed(_ sender: UICustomButton) {
        guard _figurePassedMaxCheck && !_figureContainsDecimal else { return }
        numberPadDelegate?.insertKey(".")
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    fileprivate func configureViews() {
        
        switch _calculatorType {
        case .evenSplit:
            showEvenSplitButtons()
        case .itemizedSplit:
            showItemizedSplitButtons()
        }
    }
    
    fileprivate func showEvenSplitButtons() {
        evenSplitButtons.forEach { button in
            button.layer.opacity = 1.0
        }
    }
    
    fileprivate func showItemizedSplitButtons() {
        itemizedSplitButtons.forEach { button in
            button.layer.opacity = 1.0
        }
    }
    
    // MARK: INTERNAL FUNCTIONS
    internal func deleteLastKey() {
        _currentFigure.removeLast()
    }
    
    internal func setType(_ type: CalculatorType) {
        _calculatorType = type
    }
}
