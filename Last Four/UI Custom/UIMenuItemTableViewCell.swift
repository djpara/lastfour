//
//  UIMenuItemTableViewCell.swift
//  Split Check
//
//  Created by David Para on 4/14/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class UIMenuItemTableViewCell: UITableViewCell {
    
    // MARK: Internal properties
    
    internal var menuItem: MenuItem! {
        didSet {
            titleLabel.text = menuItem.title ?? ""
        }
    }
    
    // MARK: IBOutlet properties
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    // MARK: Override functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        selectedBackgroundView = backgroundView
        
    }
    
}
