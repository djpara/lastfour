//
//  QuestionSplittingViewController.swift
//  Last Four
//
//  Created by David Para on 3/22/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class QuestionSplittingViewController: UIViewController {

    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    @objc
    fileprivate func showView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layer.opacity = 1.0
        })
    }

    fileprivate func addObservers() {
        notificationCenterDefault.addObserver(self, selector: #selector(showView), name: .containerFinishedLoading, object: nil)
    }
    
    fileprivate func removeObservers() {
        notificationCenterDefault.removeObserver(self)
    }
    
}
