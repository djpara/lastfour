//
//  ItemsTableDelegate.swift
//  Split Check
//
//  Created by David Para on 4/11/18.
//  Copyright © 2018 parad. All rights reserved.
//

import Foundation

protocol ItemsTableDelegate {
    func showItemsTable()
    func hideItemsTable()
    func removeItem(atIndex Index: Int)
}
