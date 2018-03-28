//
//  BillTotalViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class BillTotalViewController: UIViewController {

    fileprivate weak var _numberPad: NumberPadViewController?
    
    fileprivate var _ogBorderColor: UIColor?
    
    @IBOutlet weak var inputField: UICustomView!
    @IBOutlet weak var inputFieldCenterYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ogBorderColor = inputField.borderColor
    }

    // MARK: IBACTION FUNCTIONS
    @IBAction func inputFieldPressed(_ sender: Any) {
        guard _numberPad == nil else { return }
        showNumberPad()
        animateInputFieldUp()
    }
    
    @IBAction func backspaceSwipe(_ sender: Any) {
        inputText.text?.removeLast()
    }
    
    fileprivate func showNumberPad() {
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

extension BillTotalViewController: NumberPadDelegate {
    func insertKey(_ num: String) {
        // Local helper variables
        let p = "."
        let double0 = "00"
        let single0 = "0"
        
        // Check conditions
        if let text = inputText.text, text.contains(p), (num == p || (text.count > 2 && text.index(of: Character(p)) == String.Index.init(encodedOffset: (text.count - 3)))) { return }
        if let text = inputText.text, text.contains(p), (num == double0 && text.index(of: Character(p)) == String.Index.init(encodedOffset: (text.count - 2))) { inputText.text?.append(single0); return }
        if let text = inputText.text, text.count > 9 && (text.index(of: Character(p)) != String.Index.init(encodedOffset: (text.count - 1)) && text.index(of: Character(p)) != String.Index.init(encodedOffset: (text.count - 2))) { return }
        if let count = inputText.text?.count, count > 8 && num == double0 { inputText.text?.append(single0); return }
        
        inputText.text?.append(num)
    }
    
    func removeLast() {
        // TODO:
    }
    
    func close() {
        _numberPad?.numberPadDelegate = nil
        inputText.text = ""
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            let target = self.view.frame.height + (self._numberPad?.preferredContentSize.height ?? 0)
            self._numberPad?.view.frame.origin.y = target
        }) { finished in
            self._numberPad?.willMove(toParentViewController: nil)
            self._numberPad?.view.removeFromSuperview()
            self._numberPad?.removeFromParentViewController()
            self._numberPad = nil
        }
        animateInputFieldDown()
    }
    
    func addItem() {
        // TODO:
    }
    
    func enter() {
        // TODO:
    }
    
    func keyboardDown() {
        // TODO:
    }
    
    
}
