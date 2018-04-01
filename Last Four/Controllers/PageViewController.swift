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
        let billTotalViewController = mainStoryboard.instantiateViewController(withIdentifier: BILL_TOTAL_VIEW_CONTROLLER) as! BillSumViewController
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
    
    fileprivate var _firstPass = true
    
    // MARK: INTERNAL PROPERTIES
    // MARK: Internal getter and setter properties
    internal var orderedSequence: [UIViewController] {
        get {
            return _orderedSequence ?? []
        }
    }
    
    // MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        if _firstPass {
            setControllers()
            addObservers()
            _firstPass = false
        }
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    fileprivate func resetExtension() {
        // Clear the extensions
        delegate = nil
        dataSource = nil
        
        // Set the extensions
        delegate = self
        dataSource = self
    }
    
    fileprivate func addObservers() {
        notificationCenterDefault.addObserver(self, selector: #selector(setControllers), name: .newCalculatorTypeElected, object: nil)
    }
    
    @objc
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
