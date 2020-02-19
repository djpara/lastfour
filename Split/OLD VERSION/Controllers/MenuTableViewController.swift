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
    
    internal var menuDelegate: MenuDelegate?
    
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
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return _menuItems.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MENU_ITEM_CELL, for: indexPath) as? UIMenuItemTableViewCell else { return UITableViewCell() }
        
        cell.menuItem = menuItems[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuItem = _menuItems[indexPath.row].type else { return }
        
        switch menuItem {
        case .reset:
            menuDelegate?.close()
            notificationCenterDefault.post(NOTIFICATION_RESET)
            break
        case .simpleTip:
            menuDelegate?.close()
            notificationCenterDefault.post(NOTIFICATION_SHOW_SIMPLE_TIP)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.darkText
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.darkText
        return view
    }

}
