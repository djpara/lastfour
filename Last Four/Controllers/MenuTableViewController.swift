//
//  MenuTableViewController.swift
//  Split Check
//
//  Created by David Para on 4/14/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    // MARK: FILEPRIVATE FUNCTIONS
    
    fileprivate var _menuItems: [MenuItem] = []
    
    // MARK: INTERNAL FUNCTIONS
    
    internal var menuItems: [MenuItem] {
        get {
            return _menuItems
        }
        set {
            _menuItems = newValue
            if _menuItems.count < 10 {
                tableView.isScrollEnabled = false
            }
        }
    }

    // MARK: OVERRIDE FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return _menuItems.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MENU_ITEM_CELL, for: indexPath) as? UIMenuItemTableViewCell else { return UITableViewCell() }
        
        cell.menuItem = menuItems[indexPath.row]

        return cell
    }

}
