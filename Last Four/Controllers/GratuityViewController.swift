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
    
    // MARK: IBOUTLET PROPERTIES
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesNoButtonsStack: UIStackView!
    @IBOutlet weak var tipButtonsStack: UIStackView!
    @IBOutlet weak var noTipButton: UICustomButton!
    @IBOutlet weak var leaveTipButton: UICustomButton!
    
    @IBOutlet weak var inputField: UICustomView!
    @IBOutlet weak var tipButtonsStackYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputText: UILabel!
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: IBACTION FUNCTIONS
    @IBAction func yesPressed(_ sender: Any) {
        if wasGratuityIncluded == nil {
            wasGratuityIncluded = true
            animateMessage(LEAVE_ADDTL_TIP)
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
        } else {
            willLeaveTip = false
            animateMessage(NO_TIP)
            showNoTipButtons()
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
        inputText.text = Brain.instance.getTipAmount()
    }
    
    @IBAction func eighteenPressed(_ sender: Any) {
        Brain.instance.tipPercentage = 0.18
        inputText.text = Brain.instance.getTipAmount()
    }
    
    @IBAction func twentyPressed(_ sender: Any) {
        Brain.instance.tipPercentage = 0.2
        inputText.text = Brain.instance.getTipAmount()
    }
    
    @IBAction func customPressed(_ sender: Any) {
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    fileprivate func configureViews() {
        questionLabel.text = GRATUITY_INCLUDED
    }
    
    fileprivate func animateMessage(_ message: String) {
        UIView.animate(withDuration: 0.25, animations: {
            self.questionLabel.layer.opacity = 0.0
        }, completion: { finished in
            self.questionLabel.text = message
            UIView.animate(withDuration: 0.25, animations: {
                self.questionLabel.layer.opacity = 1.0
            })
        })
    }
    
    fileprivate func showTipButtons() {
        UIView.animate(withDuration: 0.25, animations: {
            self.yesNoButtonsStack.layer.opacity = 0.0
            self.leaveTipButton.layer.opacity = 0.0
        }, completion: { finished in
            UIView.animate(withDuration: 0.25, animations: {
                self.tipButtonsStack.layer.opacity = 1.0
                self.noTipButton.layer.opacity = 1.0
            })
        })
    }
    
    fileprivate func showNoTipButtons() {
        UIView.animate(withDuration: 0.25, animations: {
            self.yesNoButtonsStack.layer.opacity = 0.0
            self.tipButtonsStack.layer.opacity = 0.0
            self.noTipButton.layer.opacity = 0.0
        }, completion: { finished in
            UIView.animate(withDuration: 0.25, animations: {
                self.leaveTipButton.layer.opacity = 1.0
            })
        })
    }
    
    // MARK: INTERNAL FUNCTIONS
}

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
        // TODO:
    }
    
    func enter() {
        _numberPad?.numberPadDelegate = nil
        
        // TODO:
    }
    
    func close() {
        _numberPad?.numberPadDelegate = nil
        
        clear()
        hideNumberPad()
    }
    
    func clear() {
        inputText.text = ""
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
    
    
}
