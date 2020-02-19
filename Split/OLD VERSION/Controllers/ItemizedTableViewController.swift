//
//  ItemizedTableViewController.swift
//  Split Check
//
//  Created by David Para on 4/7/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class ItemizedTableViewController: UITableViewController {
    
    // MARK: FILEPRIVATE PROPERTIES
    
    fileprivate var _items: [Double] = []
    
    fileprivate var _itemsTableDelegate: ItemsTableDelegate?
    
    // MARK: INTERNAL PROPERTIES
    
    internal var itemsTableDelegate: ItemsTableDelegate? {
        get { return _itemsTableDelegate }
        set { _itemsTableDelegate = newValue }
    }
    
    internal var items: [Double] {
        get { return _items }
        set { _items = newValue }
    }
    
    // MARK: OVERRIDE FUNCTIONS

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !_items.isEmpty {
            tableView.isScrollEnabled = true
            return _items.count
        }
        
        tableView.isScrollEnabled = false
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !_items.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ITEMS_TABLE_CELL, for: indexPath) as? UIItemizedTableViewCell else {
                return UITableViewCell()
            }
            
            cell.itemLabel.text = "$\(_items[indexPath.row].toDollarFormat())"
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NO_ITEMS_CELL, for: indexPath)
        
        return cell
    }
    
    deinit {
        print("Itemized Table Controller deinitialized")
    }
    
    // MARK: FILEPRIVATE FUNCTIONS
    
    fileprivate func configureView() {
    }
    
}
