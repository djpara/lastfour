//
//  ViewController.swift
//  Last Four
//
//  Created by David Para on 3/20/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel               : UILabel!
    @IBOutlet weak var welcomeTextView          : UITextView!
    @IBOutlet weak var getstartedButton         : UICustomButton!
    @IBOutlet weak var menuButton               : UICustomButton!
    
    @IBOutlet weak var titleYConstraint         : NSLayoutConstraint!
    @IBOutlet weak var titleXConstraint         : NSLayoutConstraint!
    @IBOutlet weak var buttonXConstraint        : NSLayoutConstraint!
    @IBOutlet weak var welcomeTextXConstraint   : NSLayoutConstraint!
    
    @IBOutlet weak var containerView            : UIView!
    
    fileprivate var _screenWidth    = UIScreen.main.bounds.width
    fileprivate var _screenHeight   = UIScreen.main.bounds.height
    
    fileprivate var _orderedControllers: [UIViewController] = []
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateViews()
    }
    
    // MARK: IBACTION FUNCTIONS
    @IBAction func getStartedPressed(_ sender: Any) {
        repositionTitleLeft()
        showMenuButton()
        fadeLeftOutWelcomeScreen()
        fadeInContainerView()
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        print("Menu pressed")
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    // MARK: Animation functions
    fileprivate func animateViews() {
        perform(#selector(fadeInTitle), with: nil, afterDelay: 1.0)
    }
    
    /**
     Fades the title in
     */
    @objc
    fileprivate func fadeInTitle() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.titleLabel.layer.opacity = 1.0
        }, completion: { finished in
            self.repositionTitleUp()
        })
    }
    
    /**
     Brings container to the forefront. The container view holds the entire app views
     */
    fileprivate func fadeInContainerView() {
        
        
        UIView.animate(withDuration: 1, animations: {
            self.containerView.layer.opacity = 1.0
            self.view.layoutIfNeeded()
        }) { finished in
            notificationCenterDefault.post(NOTIFICATION_CONTAINER_FINISHED_LOADING)
        }
    }
    
    /**
     Repositions while animated contents of the welcome screen left and out of view
     */
    fileprivate func fadeLeftOutWelcomeScreen() {
        fadeLeftOutWelcomeText()
        fadeLeftOutGetStartedButton()
    }
    
    /**
     Repositions while animating welcome text left and out of view
     */
    fileprivate func fadeLeftOutWelcomeText() {
        UIView.animate(withDuration: 1.0, animations: {
            self.welcomeTextXConstraint.constant -= self._screenWidth
            self.view.layoutIfNeeded()
        }) { finished in
            self.welcomeTextView.removeFromSuperview()
            self.welcomeTextView = nil
        }
    }
    
    /**
     Repositions while animating get started button left and out of view
     */
    fileprivate func fadeLeftOutGetStartedButton() {
        UIView.animate(withDuration: 1.0, animations: {
            self.buttonXConstraint.constant
                -= self._screenWidth
            self.view.layoutIfNeeded()
        }) { finished in
            self.getstartedButton.removeFromSuperview()
            self.getstartedButton = nil
        }
    }
    
    /**
     Repositions while animating the title to the top of the page
     */
    fileprivate func repositionTitleUp() {
        let newConstant = ((_screenHeight / 2) - 56)
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseInOut, animations: {
            self.titleYConstraint.constant -= newConstant
            self.view.layoutIfNeeded()
            self.perform(#selector(self.showWelcomeText), with: nil, afterDelay: 1.35)
        }, completion: nil)
    }
    
    /**
     Repositions while animating the title to the left of the page
     */
    fileprivate func repositionTitleLeft() {
        let newConstant = (_screenWidth/2) - (titleLabel.intrinsicContentSize.width/2) - 16
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseInOut, animations: {
            self.titleXConstraint.constant -= newConstant
            self.view.layoutIfNeeded()
        }, completion: { finished in
        })
    }
    
    /**
     Slowly brings the welcome text to view in the middle of the view
     */
    @objc
    fileprivate func showWelcomeText() {
        welcomeTextView.isHidden = false
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.welcomeTextView.layer.opacity = 1.0
        }, completion: { finished in
            self.showGetStartedButton()
        })
    }
    
    /**
     Slowly brings the get started button to view at the bottom of the view
     */
    fileprivate func showGetStartedButton() {
        getstartedButton.show()
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.getstartedButton.layer.opacity = 1.0
        }, completion: nil)
    }
    
    /**
     Slowly brings the menu button to view at the top right-hand corner of the view
     */
    fileprivate func showMenuButton() {
        menuButton.show()
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseInOut, animations: {
            self.menuButton.layer.opacity = 1.0
        }, completion: nil)
    }
    
}

