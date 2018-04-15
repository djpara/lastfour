//
//  MenuItem.swift
//  Split Check
//
//  Created by David Para on 4/14/18.
//  Copyright © 2018 parad. All rights reserved.
//

import Foundation

class MenuItem {
    fileprivate var _type: MenuItemType?
    fileprivate var _title: String?
    
    internal var type: MenuItemType? {
        get { return _type }
        set { _type = newValue }
    }
    
    internal var title: String? {
        get { return _title }
        set { _title = newValue }
    }
    
    init(type: MenuItemType, title: String) {
        _type = type
        _title = title
    }
}
