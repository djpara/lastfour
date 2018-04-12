//
//  ViewController.swift
//  Last Four
//
//  Created by David Para on 3/20/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel                           : UILabel!
    @IBOutlet weak var menuButton                           : UICustomButton!
    
    @IBOutlet weak var titleYConstraint                     : NSLayoutConstraint!
    @IBOutlet weak var titleXConstraint                     : NSLayoutConstraint!
    
    @IBOutlet weak var pageContainerView                    : UIView!
    @IBOutlet weak var layoverContainerView                 : UIView!
    
    fileprivate weak var _questionSplittingViewController    : QuestionSplittingViewController?
    fileprivate weak var _yourTotalViewController            : YourTotalViewController?
    
    fileprivate weak var _layoverViewController             : UIViewController?
    
    fileprivate var _calculatorTypeElectionNeeded = false
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        repositionTitle()
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        print("Menu pressed")
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    fileprivate func addObservers() {
        notificationCenterDefault.addObserver(self, selector: #selector(hideLayoverContainerView), name: .newCalculatorTypeElected, object: nil)
        notificationCenterDefault.addObserver(self, selector: #selector(processNewTotalRequest), name: .requestCalculation, object: nil)
        notificationCenterDefault.addObserver(self, selector: #selector(processCloseTotalAndRestart), name: .yourTotalDonePressed, object: nil)
        notificationCenterDefault.addObserver(self, selector: #selector(processCloseTotal), name: .yourTotalBackPressed, object: nil)
    }
    
    fileprivate func removeObservers() {
        notificationCenterDefault.removeObserver(self)
    }
    
    fileprivate func configureLayoverView() {
        if _calculatorTypeElectionNeeded {
            presentViewControllerInLayoverContainer(withIdentifier: QUESTION_SPLITTING_VIEW_CONTROLLER)
            _calculatorTypeElectionNeeded = false
        }
    }
    
    // MARK: Animation functions
    /**
     Repositions while animating the title to the top of the page
     */
    fileprivate func repositionTitle() {
        
        let newYConstantDiff = ((screenHeight / 2) - 56)
        let newXConstantDiff = (screenWidth/2) - (titleLabel.intrinsicContentSize.width/2) - 16
        
        UIView.animate(withDuration: 0.75, delay: 1.0, options: .curveEaseInOut, animations: {
            self.titleYConstraint.constant -= newYConstantDiff
            self.titleXConstraint.constant -= newXConstantDiff
            self.view.layoutIfNeeded()
        }, completion: { finished in
            self._calculatorTypeElectionNeeded = true
            self.menuButton.fadeIn(duration: 0.5)
            self.configureLayoverView()
            self.layoverContainerView.fadeIn(duration: 1.0, completion: { finished in
                self.pageContainerView.layer.opacity = 1.0
            })
        })
    }
    
    /**
     Loads and add a view controller to the the view controller to the stack within the WelcomeViewController's container
     */
    fileprivate func presentViewControllerInLayoverContainer(withIdentifier identifier: String) {
        _layoverViewController = mainStoryboard.instantiateViewController(withIdentifier: identifier)
        
        guard let layoverViewController = _layoverViewController, let lcView = layoverViewController.view else { return }
        
        addChildViewController(layoverViewController)
        
        lcView.frame = layoverContainerView.bounds
        layoverContainerView.addSubview(lcView)
    }
    
    fileprivate func removeLayoverContainerViewSubviews() {
        self.layoverContainerView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    /**
     Restarts the application at a clean slate
     */
    fileprivate func restartApplication() {
        Brain.instance.clear()
        _calculatorTypeElectionNeeded = true
        configureLayoverView()
        layoverContainerView.fadeIn(duration: 0.5, completion: { finished in
            self.pageContainerView.fadeIn(duration: 0.0)
        })
    }
    
    /**
     Loads and displays the total view controller
     */
    @objc
    fileprivate func processNewTotalRequest() {
        presentViewControllerInLayoverContainer(withIdentifier: YOUR_TOTAL_VIEW_CONTROLLER)
        (_layoverViewController as? YourTotalViewController)?.totalLabel.text = "$"+Brain.instance.getTotal()
        
        layoverContainerView.fadeIn(duration: 0.5)
    }
    
    /**
     Closes the layover container and restarts the application
     */
    @objc
    fileprivate func processCloseTotalAndRestart() {
        pageContainerView.layer.opacity = 0.0
        layoverContainerView.fadeOut(duration: 0.5, completion: { finished in
            self.removeLayoverContainerViewSubviews()
            self._layoverViewController?.removeFromParentViewController()
            self.restartApplication()
        })
    }
    
    /**
     Closes the layover container
     */
    @objc
    fileprivate func processCloseTotal() {
        layoverContainerView.fadeOut(duration: 0.5, completion: { finished in
            self.removeLayoverContainerViewSubviews()
            self._layoverViewController?.removeFromParentViewController()
        })
    }
    /**
     Removes the layover container view from the forefront of the view hierarchy
     */
    @objc
    fileprivate func hideLayoverContainerView() {
        layoverContainerView.fadeOut(duration: 0.5, completion: { finished in
            self.removeLayoverContainerViewSubviews()
            self._layoverViewController?.removeFromParentViewController()
        })
    }
    
    /**
     Removes the layover container view from the forefront of the view hierarchy
     */
    @objc
    fileprivate func hidePageContainerView() {
        pageContainerView.fadeOut(duration: 0.5)
    }
    
}

