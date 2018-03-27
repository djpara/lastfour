//
//  BillTotalViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class BillTotalViewController: UIViewController {

    fileprivate var _numberPad: NumberPadViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: IBACTION FUNCTIONS
    @IBAction func inputFieldPressed(_ sender: Any) {
        _numberPad = utilityStoryboard.instantiateViewController(withIdentifier: NUMBER_PAD_VIEW_CONTROLLER) as? NumberPadViewController
        _numberPad?.numberPadDelegate = self
        _numberPad?.setType(.evenSplit)
        
        _numberPad?.view.frame.origin.y = view.frame.height + (_numberPad?.preferredContentSize.height)!
        
        view.insertSubview((_numberPad?.view)!, at: 10)
        
        addChildViewController(_numberPad!)
        view.addSubview((_numberPad?.view)!)
        _numberPad?.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            let target = self.view.frame.height - (self._numberPad?.preferredContentSize.height ?? 0)
            self._numberPad?.view.frame.origin.y = target
        }, completion: nil)
        
        print("Input field tapped")
    }
}

extension BillTotalViewController: NumberPadDelegate {
    func insertKey(_ num: String) {
        // TODO:
    }
    
    func removeLast() {
        // TODO:
    }
    
    func cancel() {
        // TODO:
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
