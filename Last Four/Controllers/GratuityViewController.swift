//
//  GratuityViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class GratuityViewController: UIViewController {

    // MARK: FINAL PROPERTIES
    final let GRATUITY_INCLUDED     = "Was gratuity included?"
    final let LEAVE_ADDTL_TIP       = "Would you like to leave an additional tip?"
    final let LEAVE_TIP             = "Would you like to leave a tip?"
    final let TIP_AMOUNT            = "How much would you like to leave?"
    final let NO_TIP                = "Not leaving tip."
    
    // MARK: FILEPRIVATE PROPERTIES
    fileprivate var wasGratuityIncluded: Bool?
    fileprivate var willLeaveTip: Bool?
    
    fileprivate weak var _numberPad: NumberPadViewController?
    
    fileprivate var _ogBorderColor: UIColor?
    
    fileprivate var _willLeaveCustomPercentage = false
    
    // MARK: IBOUTLET PROPERTIES
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesNoButtonsStack: UIStackView!
    @IBOutlet weak var tipButtonsStack: UIStackView!
    @IBOutlet weak var nextStack: UIStackView!
    @IBOutlet weak var leaveTipButton: UIStackView!
    
    @IBOutlet weak var inputField: UICustomView!
    @IBOutlet weak var tipButtonsStackYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputTextDollar: UILabel!
    @IBOutlet weak var inputTextPercent: UILabel!
    
    @IBOutlet weak var dollarSign: UILabel!
    @IBOutlet weak var percentSign: UILabel!
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputTextDollar.text = Brain.instance.tipAmount.toDollarFormat()
    }
    
    // MARK: IBACTION FUNCTIONS
    @IBAction func yesPressed(_ sender: Any) {
        if wasGratuityIncluded == nil {
            wasGratuityIncluded = true
            animateMessage(LEAVE_ADDTL_TIP)
            yesNoButtonsStack.fadeOut(duration: 0.25, completion: { finished in
                self.yesNoButtonsStack.fadeIn(duration: 0.25)
            })
        } else {
            willLeaveTip = true
            animateMessage(TIP_AMOUNT)
            showTipButtons()
        }
    }
    
    @IBAction func noPressed(_ sender: Any) {
        if wasGratuityIncluded == nil {
            wasGratuityIncluded = false
            animateMessage(LEAVE_TIP)
            yesNoButtonsStack.fadeOut(duration: 0.25, completion: { finished in
                self.yesNoButtonsStack.fadeIn(duration: 0.25)
            })
        } else {
            willLeaveTip = false
            animateMessage(NO_TIP)
            showNoTipButtons()
        }
    }
    
    @IBAction func inputFieldPressed(_ sender: Any) {
        guard _numberPad == nil else { return }
        showNumberPad()
        animateInputFieldUp()
    }
    
    @IBAction func backspaceSwipe(_ sender: Any) {
        if _willLeaveCustomPercentage {
            guard inputTextPercent.text != "" else { return }
            inputTextPercent.text?.removeLast()
        } else {
            guard inputTextDollar.text != "" else { return }
            inputTextDollar.text?.removeLast()
        }
    }
    
    @IBAction func leaveTipPressed(_ sender: Any) {
        willLeaveTip = true
        animateMessage(TIP_AMOUNT)
        showTipButtons()
    }
    
    @IBAction func noTipPressed(_ sender: Any) {
        willLeaveTip = false
        Brain.instance.tipAmount = 0.0
        Brain.instance.tipPercentage = 0.0
        animateMessage(NO_TIP)
        showNoTipButtons()
    }
    
    @IBAction func fifteenPressed(_ sender: Any) {
        Brain.instance.tipPercentage = 0.15
        if _willLeaveCustomPercentage {
            inputTextPercent.text = "15"
        } else {
            inputTextDollar.text = Brain.instance.getTipAmount()
        }
    }
    
    @IBAction func eighteenPressed(_ sender: Any) {
        Brain.instance.tipPercentage = 0.18
        if _willLeaveCustomPercentage {
            inputTextPercent.text = "18"
        } else {
            inputTextDollar.text = Brain.instance.getTipAmount()
        }
    }
    
    @IBAction func twentyPressed(_ sender: Any) {
        Brain.instance.tipPercentage = 0.2
        if _willLeaveCustomPercentage {
            inputTextPercent.text = "20"
        } else {
            inputTextDollar.text = Brain.instance.getTipAmount()
        }
    }
    
    @IBAction func customPressed(_ sender: Any) {
        guard _numberPad == nil else {
            _willLeaveCustomPercentage = true
            animateShowPercentInput()
            return
        }
        _willLeaveCustomPercentage = true
        animateShowPercentInput()
        showNumberPad()
        animateInputFieldUp()
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        guard let pageViewController = (parent as? PageViewController) else { return }
        
        pageViewController.setViewControllers([pageViewController.orderedSequence[2]], direction: .forward, animated: true, completion: nil)
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    fileprivate func configureViews() {
        _ogBorderColor = inputField.borderColor
        questionLabel.text = GRATUITY_INCLUDED
    }
    
    fileprivate func animateMessage(_ message: String) {
        questionLabel.fadeOut(duration: 0.25, completion: { finished in
            self.questionLabel.text = message
            self.questionLabel.fadeIn(duration: 0.25)
        })
    }
    
    fileprivate func showTipButtons() {
        UIView.animate(withDuration: 0.25, animations: {
            self.yesNoButtonsStack.layer.opacity = 0.0
            self.leaveTipButton.layer.opacity = 0.0
        }, completion: { finished in
            UIView.animate(withDuration: 0.25, animations: {
                self.tipButtonsStack.layer.opacity = 1.0
                self.nextStack.layer.opacity = 1.0
            })
        })
    }
    
    fileprivate func showNoTipButtons() {
        UIView.animate(withDuration: 0.25, animations: {
            self.yesNoButtonsStack.layer.opacity = 0.0
            self.tipButtonsStack.layer.opacity = 0.0
            self.nextStack.layer.opacity = 0.0
        }, completion: { finished in
            UIView.animate(withDuration: 0.25, animations: {
                self.leaveTipButton.layer.opacity = 1.0
            })
        })
    }
    
    fileprivate func animateInputFieldUp() {
        // Bring inputfield up a bit
        inputField.borderColor = ASTRONAUT_BLUE
        UIView.animate(withDuration: 0.5, animations: {
            self.tipButtonsStackYConstraint.constant -= self.inputField.frame.height
            self.view.layoutIfNeeded()
        })
    }
    
    fileprivate func animateInputFieldDown() {
        // Bring inputfield down a bit
        if let ogBorderColor = self._ogBorderColor {
            self.inputField.borderColor = ogBorderColor
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.tipButtonsStackYConstraint.constant += self.inputField.frame.height
            self.view.layoutIfNeeded()
        })
    }
    
    fileprivate func animateShowPercentInput() {
        UIView.animate(withDuration: 0.1, animations: {
            self.percentSign.layer.opacity = 1.0
            self.inputTextPercent.layer.opacity = 1.0
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                self.dollarSign.layer.opacity = 0.0
                self.inputTextDollar.layer.opacity = 0.0
            })
        })
    }
    
    fileprivate func animateShowDollarInput() {
        UIView.animate(withDuration: 0.1, animations: {
            self.dollarSign.layer.opacity = 1.0
            self.inputTextDollar.layer.opacity = 1.0
        }, completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                self.percentSign.layer.opacity = 0.0
                self.inputTextPercent.layer.opacity = 0.0
            })
        })
    }
    
    // MARK: INTERNAL FUNCTIONS
}

// Number Pad Delegate extension
extension GratuityViewController: NumberPadDelegate {
    
    func showNumberPad() {
        _numberPad = utilityStoryboard.instantiateViewController(withIdentifier: NUMBER_PAD_VIEW_CONTROLLER) as? NumberPadViewController
        _numberPad?.numberPadDelegate = self
        _numberPad?.setType(.evenSplit)
        
        _numberPad?.view.frame.origin.y = view.frame.height + (_numberPad?.preferredContentSize.height)!
        
        view.insertSubview((_numberPad?.view)!, at: 10)
        
        addChildViewController(_numberPad!)
        view.addSubview((_numberPad?.view)!)
        _numberPad?.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            let target = self.view.frame.height - (self._numberPad?.preferredContentSize.height ?? 0)
            self._numberPad?.view.frame.origin.y = target
        }, completion: nil)
    }
    
    func hideNumberPad() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            let target = self.view.frame.height + (self._numberPad?.preferredContentSize.height ?? 0)
            self._numberPad?.view.frame.origin.y = target
        }) { finished in
            self._numberPad?.willMove(toParentViewController: nil)
            self._numberPad?.view.removeFromSuperview()
            self._numberPad?.removeFromParentViewController()
            self._numberPad = nil
        }
    }
    
    func insertKey(_ num: String) {
        
        if _willLeaveCustomPercentage {
            insertKey(num, into: inputTextPercent)
        } else {
            insertKey(num, into: inputTextDollar)
        }
    }
    
    func enter() {
        _numberPad?.numberPadDelegate = nil
        
        if _willLeaveCustomPercentage {
            if let text = inputTextPercent.text, let percent = Double(text) {
                Brain.instance.tipPercentage = percent/100
                inputTextDollar.text = Brain.instance.getTipAmount()
                animateShowDollarInput()
                inputTextPercent.text = ""
                _willLeaveCustomPercentage = false
            }
        } else {
            if let text = inputTextDollar.text, let amount = Double(text) {
                Brain.instance.tipAmount = amount
            }
        }
        
        hideNumberPad()
        animateInputFieldDown()
    }
    
    func close() {
        _numberPad?.numberPadDelegate = nil
        
        if _willLeaveCustomPercentage {
            animateShowDollarInput()
            _willLeaveCustomPercentage = false
        }
        
        hideNumberPad()
        animateInputFieldDown()
    }
    
    func clear() {
        if _willLeaveCustomPercentage {
            Brain.instance.tipPercentage = 0.0
            inputTextPercent.text = ""
        } else {
            Brain.instance.tipAmount = 0.0
            inputTextDollar.text = ""
        }
    }
    
    func removeLast() {
        // Not implemented
    }
    
    func addItem() {
        // Not implemented
    }
    
    func keyboardDown() {
        // Not implemented
    }
    
    // MARK: EXTENSION HELPER FUNCTIONS
    fileprivate func insertKey(_ num: String, into label: UILabel) {
        // Local helper variables
        let e = ""
        let p = "."
        let s = "0"
        let d = "00"
        
        guard let text = label.text else { return }
        
        // CASE: Current input is zero. User taps zero or point
        if Double(text) == 0.0 || text == e {
            if num == p {
                label.text = s+p
            } else if num == d || num == s {
                if text == s+p {
                    label.text?.append(num)
                } else {
                    label.text = (s)
                }
            } else {
                if text == s+p+d {
                    label.text = num
                } else {
                    label.text?.append(num)
                }
            }
            
            return
        }
        
        // CASE: User taps point
        if text.contains(p) {
            let split = text.split(separator: Character(p))
            
            if split.count > 1 && (split[1].count > 1
                || (split[1].count > 0 && num == d)) {} // Fall to return
            else if num == p {} // Fall to return
            else { label.text?.append(num) }
            
            return
        }
        
        // CASE: Total digits exceeds 10 and the next tap is not point
        if text.count > 9, num != p { return }
        
        // CASE: Total digits exceeds 14
        if text.count > 13 { return }
        
        label.text?.append(num)
    }
    
}
