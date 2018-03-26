//
//  PageViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    //MARK: FILEPRIVATE PROPERTIES
    fileprivate lazy var _evenSplitSequence: [UIViewController] = {
        let billTotalViewController = mainStoryboard.instantiateViewController(withIdentifier: BILL_TOTAL_VIEW_CONTROLLER) as! BillTotalViewController
        let gratuityViewController = mainStoryboard.instantiateViewController(withIdentifier: GRATUITY_VIEW_CONTROLLER) as! GratuityViewController
        let peopleTotalViewController = mainStoryboard.instantiateViewController(withIdentifier: PEOPLE_TOTAL_VIEW_CONTROLLER) as! PeopleTotalViewController
        
        return [billTotalViewController, gratuityViewController, peopleTotalViewController]
    }()
    
    fileprivate lazy var _itemizedSplitSequence: [UIViewController] = {
        let itemizedViewController = mainStoryboard.instantiateViewController(withIdentifier: ITEMIZED_VIEW_CONTROLLER) as! ItemizedViewController
        let gratuityViewController = mainStoryboard.instantiateViewController(withIdentifier: GRATUITY_VIEW_CONTROLLER) as! GratuityViewController
        
        return [itemizedViewController, gratuityViewController]
    }()
    
    fileprivate var _orderedSequence: [UIViewController]?
    fileprivate var _layoverController: UIViewController?
    
    fileprivate var _calculatorTypeSelected = false
    fileprivate var _readyForTotal = false
    
    //MARK: INTERNAL PROPERTIES
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageViewController()
        addObservers()
        
        // This will be done once at viewDidLoad
        presentQuestionSplittingViewController()
    }
    
    override func loadView() {
        super.loadView()
        configureViews()
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    fileprivate func configureViews() {
        if !_calculatorTypeSelected {
            // Make view transparent
            view.layer.opacity = 0.0
        }
    }
    
    fileprivate func setUpPageViewController() {
        // Load and set the ordered controllers
        setControllers()
    }
    
    fileprivate func setControllers() {
        
        switch Preferences.instance.calculatorType {
        case .evenSplit:
            _orderedSequence = _evenSplitSequence
            if let sequence = _orderedSequence, let first = sequence.first {
                setViewControllers([first], direction: .forward, animated: true, completion: nil)
            }
        case .itemizedSplit:
            _orderedSequence = _itemizedSplitSequence
            if let sequence = _orderedSequence, let first = sequence.first {
                setViewControllers([first], direction: .forward, animated: true, completion: nil)
            }
        }
    
        resetExtension()
        loadView()
    }
    
    fileprivate func resetExtension() {
        // Clear the extensions
        delegate = nil
        dataSource = nil
        
        // Set the extensions
        delegate = self
        dataSource = self
    }
    
    fileprivate func addObservers() {
        notificationCenterDefault.addObserver(self, selector: #selector(showView), name: .containerFinishedLoading, object: nil)
        notificationCenterDefault.addObserver(self, selector: #selector(reloadControllers), name: .newCalculatorTypeElected, object: nil)
    }
    
    fileprivate func removeObservers() {
        notificationCenterDefault.removeObserver(self)
    }
    
    fileprivate func presentQuestionSplittingViewController() {
        _layoverController = mainStoryboard.instantiateViewController(withIdentifier: QUESTION_SPLITTING_VIEW_CONTROLLER)
        if let layoverController = _layoverController {
            layoverController.view.frame = view.bounds
            layoverController.view.layer.opacity = 0.0
            view.addSubview(layoverController.view)
            UIView.animate(withDuration: 1.0) {
                layoverController.view.layer.opacity = 1.0
            }
        }
    }
    
    @objc
    fileprivate func showView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layer.opacity = 1.0
        })
    }
    
    @objc
    fileprivate func reloadControllers() {
        _calculatorTypeSelected = true
        UIView.animate(withDuration: 0.5, animations: {
            self._layoverController?.view.subviews.forEach { view in
                view.layer.opacity = 0.0
            }
        }, completion: { finished in
            self._layoverController?.view.removeFromSuperview()
            self._layoverController = nil
            self.setControllers()
        })
    }
    
    // MARK: INTERNAL FUNCTIONS

}

// MARK: EXTENSIONS
// MARK: Page view delegate and data sourse extension
extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
        guard let index = _orderedSequence?.index(of: viewController) else { return nil }
        
        let previousIndex = index - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard let sequence = _orderedSequence, sequence.count > previousIndex else { return nil }
        
        return _orderedSequence?[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = _orderedSequence?.index(of: viewController) else { return nil }
        
        let nextIndex = index + 1
        
        guard let sequence = _orderedSequence, sequence.count != nextIndex && sequence.count > nextIndex else { return nil }
        
        return _orderedSequence?[nextIndex]
    }
    
}
