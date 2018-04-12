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
    
    deinit {
        print("Your Total Controller deinitialized")
    }
    
    @IBAction func backPressed(_ sender: Any) {
        notificationCenterDefault.post(NOTIFICATION_YOUR_TOTAL_BACK_PRESSED)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        notificationCenterDefault.post(NOTIFICATION_YOUR_TOTAL_DONE_PRESSED)
    }
}
