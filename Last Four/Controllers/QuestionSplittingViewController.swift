//
//  QuestionSplittingViewController.swift
//  Last Four
//
//  Created by David Para on 3/22/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class QuestionSplittingViewController: UIViewController {
    
    // MARK: FILEPRIVATE PROPERTIES

    // MARK: INTERNAL PROPERTIES
    
    // MARK: IBOUTLET PROPERTIES
    // TODO: Delete - using only to disable button while app in construction
    @IBOutlet weak var noButton: UICustomButton!
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
//        noButton.disable()
    }
    
    // MARK: IBACTION FUNCTIONS
    @IBAction func buttonPressed(_ sender: UICustomButton) {
        if sender.tag == 0 {
            Preferences.instance.calculatorType = .evenSplit
        } else if sender.tag == 1 {
            Preferences.instance.calculatorType = .itemizedSplit
        }
        
        notificationCenterDefault.post(NOTIFICATION_NEW_CALCULATOR_TYPE_ELECTED)
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    
}
