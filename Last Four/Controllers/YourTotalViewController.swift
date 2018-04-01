//
//  YourTotalViewController.swift
//  Last Four
//
//  Created by David Para on 3/24/18.
//  Copyright © 2018 parad. All rights reserved.
//

import UIKit

class YourTotalViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closePressed(_ sender: Any) {
        notificationCenterDefault.post(NOTIFICATION_CLOSE_YOUR_TOTAL_CONTROLLER)
    }
}
