//
//  ViewController.swift
//  Last Four
//
//  Created by David Para on 3/20/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var welcomeTextView: UITextView!
    @IBOutlet weak var getstartedButton: UICustomButton!
    
    @IBOutlet weak var titleYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateViews()
    }
    
    // MARK: Fileprivate functions
    fileprivate func loadViews() {
        
    }
    
    fileprivate func animateViews() {
        perform(#selector(fadeTitleIn), with: nil, afterDelay: 1.0)
    }
    
    /**
     Fades the title in
     */
    @objc
    fileprivate func fadeTitleIn() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.titleImage.layer.opacity = 1.0
        }, completion: { finished in
            self.repositionTitle()
        })
    }
    
    /**
     Repositions while animating the title to the top of the page
     */
    fileprivate func repositionTitle() {
        let newConstant = ((UIScreen.main.bounds.height / 2) - 56)
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseInOut, animations: {
            self.titleYConstraint.constant -= newConstant
            self.view.layoutIfNeeded()
            self.perform(#selector(self.showWelcomeText), with: nil, afterDelay: 1.25)
        }, completion: nil)
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
     Slowly brings the get started button to view at the bottom right-hand corner of the view
     */
    fileprivate func showGetStartedButton() {
        getstartedButton.show()
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseInOut, animations: {
            self.getstartedButton.layer.opacity = 1.0
        }, completion: nil)
    }
}

