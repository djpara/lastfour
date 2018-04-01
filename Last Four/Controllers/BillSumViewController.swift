//
//  BillTotalViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class BillSumViewController: UIViewController {

    // MARK: FILEPRIVATE PROPERTIES
    fileprivate weak var _numberPad: NumberPadViewController?
    
    fileprivate var _ogBorderColor: UIColor?
    
    // MARK: IBOUTLET PROPERTIES
    @IBOutlet weak var inputField: UICustomView!
    @IBOutlet weak var inputFieldCenterYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputText: UILabel!
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputText.text = Brain.instance.billSum.toDollarFormat()
    }

    // MARK: IBACTION FUNCTIONS
    @IBAction func inputFieldPressed(_ sender: Any) {
        guard _numberPad == nil else { return }
        showNumberPad()
        animateInputFieldUp()
    }
    
    @IBAction func backspaceSwipe(_ sender: Any) {
        guard inputText.text != "" else { return }
        inputText.text?.removeLast()
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        guard let pageViewController = (parent as? PageViewController) else { return }
        
        pageViewController.setViewControllers([pageViewController.orderedSequence[1]], direction: .forward, animated: true, completion: nil)
    }
    
    // MARK: FILEPRIVATE VIEWS
    fileprivate func configureViews() {
        _ogBorderColor = inputField.borderColor
    }
    
    fileprivate func animateInputFieldUp() {
        // Bring inputfield up a bit
        inputField.borderColor = ASTRONAUT_BLUE
        UIView.animate(withDuration: 0.5, animations: {
            self.inputFieldCenterYConstraint.constant -= self.inputField.frame.height
            self.view.layoutIfNeeded()
        })
    }
    
    fileprivate func animateInputFieldDown() {
        // Bring inputfield down a bit
        if let ogBorderColor = self._ogBorderColor {
            self.inputField.borderColor = ogBorderColor
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.inputFieldCenterYConstraint.constant += self.inputField.frame.height
            self.view.layoutIfNeeded()
        })
    }
    
    fileprivate func animateInputFirstResponder() {
        // Twinkle
        if let ogBorderColor = _ogBorderColor {
            inputField.borderColor = ogBorderColor
        }
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.repeat, .autoreverse, .curveEaseInOut, .allowUserInteraction],
                       animations: {
            self.inputField.borderColor = ASTRONAUT_BLUE
        }, completion: nil)
    }
    
}

// MARK: Number Pad Delegate extension
extension BillSumViewController: NumberPadDelegate {
    
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
        // Local helper variables
        let e = ""
        let p = "."
        let s = "0"
        let d = "00"
        
        guard let text = inputText.text else { return }
        
        // CASE: Current input is zero. User taps zero or point
        if Double(text) == 0.0 || text == e {
            if num == p {
                inputText.text = s+p
            } else if num == d || num == s {
                if text == s+p {
                    inputText.text?.append(num)
                } else {
                    inputText.text = (s)
                }
            } else {
                if text == s+p+d {
                    inputText.text = num
                } else {
                    inputText.text?.append(num)
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
            else { inputText.text?.append(num) }
            
            return
        }
        
        // CASE: Total digits exceeds 10 and the next tap is not point
        if text.count > 9, num != p { return }
        
        // CASE: Total digits exceeds 14
        if text.count > 13 { return }
        
        inputText.text?.append(num)
    }
    
    func enter() {
        _numberPad?.numberPadDelegate = nil
        
        if let text = inputText.text, let sum = Double(text) {
            Brain.instance.billSum = sum
            inputText.text = sum.toDollarFormat()
        } else {
            inputText.text = Brain.instance.billSum.toDollarFormat()
        }
        
        hideNumberPad()
        animateInputFieldDown()
    }
    
    func close() {
        _numberPad?.numberPadDelegate = nil
        
        // If going back to the box after already pressing enter, this will not affect what's currently stored
        if Brain.instance.billSum == 0.0 {
            clear()
        }
        
        inputText.text = Brain.instance.billSum.toDollarFormat()
        
        hideNumberPad()
        animateInputFieldDown()
    }
    
    func clear() {
        inputText.text = ""
    }
    
    func addItem() {
        // Not implemented
    }
    
    func keyboardDown() {
        // Not implemented
    }
    
    func removeLast() {
        // Not implemented
    }
     
}
