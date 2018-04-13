//
//  PeopleTotalViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class PeopleTotalViewController: UIViewController {

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
        inputText.text = String(Brain.instance.totalPlayers)
    }
    
    deinit {
        print("People Total Controller deinitialized")
    }
    
    // MARK: IBACTION FUNCTIONS
    @IBAction func inputFieldPressed(_ sender: Any) {
        guard _numberPad == nil else { return }
        showNumberPad()
        animateInputFieldUp()
        inputText.text = ""
    }
    
    @IBAction func backspaceSwipe(_ sender: Any) {
        guard inputText.text != "" else { return }
        inputText.text?.removeLast()
    }
    
    @IBAction func calculateTotalPressed(_ sender: Any) {
        notificationCenterDefault.post(NOTIFICATION_REQUEST_CALCULATION)
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
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
}

// MARK: Number Pad Delegate extension
extension PeopleTotalViewController: NumberPadDelegate {
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
        
        if text == e || Int(text) == 0 {
            if num == s || num == d { return }
        }
        
        if num == p { return }
        
        if text.count > 5 { return }
        
        inputText.text?.append(num)
    }
    
    func enter() {
        _numberPad?.numberPadDelegate = nil
        
        if let text = inputText.text, let num = Int(text), num != 0 {
            inputText.text = String(num)
            Brain.instance.totalPlayers = num
        } else {
            inputText.text = String(Brain.instance.totalPlayers)
        }
        
        hideNumberPad()
        animateInputFieldDown()
    }
    
    func close() {
        _numberPad?.numberPadDelegate = nil
        
        inputText.text = String(Brain.instance.totalPlayers)
        
        hideNumberPad()
        animateInputFieldDown()
    }
    
    func clear() {
        if inputText.text == "" {
            return
        }
        Brain.instance.totalPlayers = 1
        inputText.text = ""
    }
    
    func addItem() {
        // Not Implemented
    }
    
    func removeLast() {
        // Not Implemented
    }
}
