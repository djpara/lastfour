//
//  UIMenuItemTableViewCell.swift
//  Split Check
//
//  Created by David Para on 4/14/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class UIMenuItemTableViewCell: UITableViewCell {
    
    internal var menuItem: MenuItem! {
        didSet {
            titleLabel.text = menuItem.title ?? ""
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
}
