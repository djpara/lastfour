//
//  ItemizedViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class ItemizedViewController: UIViewController {

    // MARK: FILEPRIVATE PROPERTIES
    
    fileprivate weak var _numberPad: NumberPadViewController?
    fileprivate weak var _itemsTable: ItemizedTableViewController?
    fileprivate var _ogBorderColor: UIColor?
    fileprivate var _ogInputFieldFrameCenter: CGPoint?
    
    fileprivate var _items: [Double] = []
    fileprivate var _itemsVisible = false
    fileprivate var _isShowingFromButtonPress = false
    
    // MARK: IBOUTLET PROPERTIES
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var inputField: UICustomView!
    @IBOutlet weak var inputText: UILabel!
    @IBOutlet weak var inputFieldCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var showHideOrderButton: UICustomButton!
    @IBOutlet weak var showOrderButton: UICustomButton!
    
    // MARK: OVERRIDE FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        print("Itemized Controller deinitialized")
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    
    fileprivate func configureViews() {
        _ogBorderColor = inputField.borderColor
    }
    
    fileprivate func addObservers() {
        notificationCenterDefault.removeObserver(self)
        notificationCenterDefault.addObserver(self, selector: #selector(reset), name: .reset, object: nil)
    }
    
    fileprivate func animateInputFieldUp() {
        // Bring inputfield up a bit
        _ogInputFieldFrameCenter = inputField.center
        
        let newFrameCenter = CGPoint(x: inputField.center.x, y: (inputField.frame.height/2) + 16)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.inputField.center = newFrameCenter
        }, completion: { finished in
            self.showItemsTable()
            self.inputField.borderColor = ASTRONAUT_BLUE

        })
    }
    
    fileprivate func animateInputFieldDown() {
        // Bring inputfield down a bit
        if let ogBorderColor = self._ogBorderColor {
            self.inputField.borderColor = ogBorderColor
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.inputField.center = self._ogInputFieldFrameCenter ?? CGPoint(x: screenHeight/2, y: screenWidth/2)
        })
    }
    
    fileprivate func animateItemsTableExpand() {
        UIView.animate(withDuration: 0.5, animations: {
            self._itemsTable?.view.frame.size.height =  self.view.frame.height - 116 - (self._itemsTable?.view.frame.origin.y ?? 87) - 16
        })
    }
    
    fileprivate func animateItemsTableShrink() {
        UIView.animate(withDuration: 0.5, animations: {
            self._itemsTable?.view.frame.size.height =  self.view.frame.height - (self._numberPad?.preferredContentSize.height ?? 116) - (self._itemsTable?.view.frame.origin.y ?? 87) - 16
        })
    }
    
    // MARK: Selector functions
    
    @objc
    fileprivate func reset() {
        clear()
        _items.removeAll()
        _itemsTable?.items = _items
        _itemsTable?.tableView.reloadData()
    }
    
    // MARK: IBACTION FUNCTIONS
    
    @IBAction func inputFieldPressed(_ sender: Any) {
        guard _numberPad == nil else { return }
        clear()
        
        showNumberPad()
        messageLabel.fadeOut(duration: 0.25)
        
        if _itemsVisible {
            animateItemsTableShrink()
        } else {
            animateInputFieldUp()
        }
    }

    @IBAction func showOrderPressed(_ sender: Any) {
        showOrderButton.disable()
        
        if _itemsVisible {
            showOrderButton.setTitle("Show Order", for: .normal)
            hideItemsTable()
            _isShowingFromButtonPress = false
        } else {
            showOrderButton.setTitle("Hide Order", for: .normal)
            animateInputFieldUp()
            messageLabel.fadeOut(duration: 0.25)
            _isShowingFromButtonPress = true
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        guard let pageViewController = (parent as? PageViewController) else { return }
        
        pageViewController.setViewControllers([pageViewController.orderedSequence[1]], direction: .forward, animated: true, completion: nil)
    }
    
}

// MARK: Number Pad Delegate extension

extension ItemizedViewController: NumberPadDelegate {
    
    func showNumberPad() {
        _numberPad = utilityStoryboard.instantiateViewController(withIdentifier: NUMBER_PAD_VIEW_CONTROLLER) as? NumberPadViewController
        _numberPad?.numberPadDelegate = self
        _numberPad?.setType(.itemizedSplit)
        
        _numberPad?.view.frame.origin.y = view.frame.height + ((_numberPad?.preferredContentSize.height) ?? 260)
        
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
        
        // CASE: Current input is zero. User taps zero or point
        if Double(text) == 0.0 || text == e {
            if num == p {
                inputText.text = s+p
            } else if num == d || num == s {
                if text == s+p {
                    inputText.text?.append(num)
                } else {
                    inputText.text = (s)
                }
            } else {
                if text == s+p+d {
                    inputText.text = num
                } else {
                    inputText.text?.append(num)
                }
            }
            
            return
        }
        
        // CASE: User taps point
        if text.contains(p) {
            let split = text.split(separator: Character(p))
            
            if split.count > 1 && (split[1].count > 1
                || (split[1].count > 0 && num == d)) {} // Fall to return
            else if num == p {} // Fall to return
            else { inputText.text?.append(num) }
            
            return
        }
        
        // CASE: Total digits exceeds 10 and the next tap is not point
        if text.count > 9, num != p { return }
        
        // CASE: Total digits exceeds 14
        if text.count > 13 { return }
        
        inputText.text?.append(num)
    }
    
    func close() {
        _numberPad?.numberPadDelegate = nil
        
        // If going back to the box after already pressing enter, this will not affect what's currently stored
        if Brain.instance.billSum == 0.0 {
            clear()
        }
        
        inputText.text = Brain.instance.billSum.toDollarFormat()
        
        hideNumberPad()
        
        if _isShowingFromButtonPress {
            animateItemsTableExpand()
        } else {
            hideItemsTable()
        }
    }
    
    func clear() {
        inputText.text = ""
    }
    
    func addItem() {
        if let text = inputText.text, let item = Double(text) {
            _items.append(item)
            _itemsTable?.items = _items
            _itemsTable?.tableView.reloadData()
            
            Brain.instance.billSum = _items.reduce(0, +)
            print(Brain.instance.billSum)
        }
        
        inputText.text = ""
    }
    
    func removeLast() {
        _items.removeLast()
        _itemsTable?.items = _items
        _itemsTable?.tableView.reloadData()
        
        Brain.instance.billSum = _items.reduce(0, +)
        print(Brain.instance.billSum)
    }
    
    func enter() {
        // Not implemented
    }
    
}

extension ItemizedViewController: ItemsTableDelegate {
    func showItemsTable() {
        _itemsTable = utilityStoryboard.instantiateViewController(withIdentifier: ITEMIZED_TABLE_VIEW_CONTROLLER) as? ItemizedTableViewController
        _itemsTable?.itemsTableDelegate = self
        _itemsTable?.items = _items
        
        _itemsTable?.view.frame.origin.x = inputField.frame.origin.x + 16.0
        _itemsTable?.view.frame.origin.y = inputField.frame.origin.y + inputField.frame.height - 1
        
        _itemsTable?.view.frame.size.width = inputField.frame.width
        _itemsTable?.view.frame.size.height = 0
        
        _itemsTable?.view.layer.borderWidth = 1.0
        _itemsTable?.view.layer.cornerRadius = 4.0
        _itemsTable?.view.layer.borderColor = ASTRONAUT_BLUE.cgColor
        
        view.insertSubview((_itemsTable?.view)!, at: 10)
        
        addChildViewController(_itemsTable!)
        view.addSubview((_itemsTable?.view)!)
        _itemsTable?.didMove(toParentViewController: self)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self._itemsTable?.view.frame.size.height =  self.view.frame.height - (self._numberPad?.preferredContentSize.height ?? 116) - (self._itemsTable?.view.frame.origin.y ?? 87) - 16
        }, completion: { finished in
            self.showOrderButton.enable()
        })
        
        _itemsVisible = true
    }
    
    func hideItemsTable() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self._itemsTable?.view.frame.size.height = 0
        }) { finished in
            self._itemsTable?.willMove(toParentViewController: nil)
            self._itemsTable?.view.removeFromSuperview()
            self._itemsTable?.removeFromParentViewController()
            self._itemsTable = nil
            self.animateInputFieldDown()
            self.messageLabel.fadeIn(duration: 0.25, delay: 0.25)
            self.showOrderButton.enable()
        }
        
        _itemsVisible = false
    }
    
    func removeItem(atIndex index: Int) {
        _items.remove(at: index)
    }
    
    
}
