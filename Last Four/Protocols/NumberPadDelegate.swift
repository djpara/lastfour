//
//  KeyboardDelegate.swift
//  Last Four
//
//  Created by David Para on 3/26/18.
//  Copyright © 2018 parad. All rights reserved.
//

import Foundation

protocol NumberPadDelegate {
    func insertKey(_ num: String)
    func removeLast()
    func cancel()
    func addItem()
    func enter()
    func keyboardDown()
}
