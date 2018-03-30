//
//  KeyboardDelegate.swift
//  Last Four
//
//  Created by David Para on 3/26/18.
//  Copyright © 2018 parad. All rights reserved.
//

import Foundation

protocol NumberPadDelegate {
    func showNumberPad()
    func hideNumberPad()
    func insertKey(_ num: String)
    func removeLast()
    func close()
    func clear()
    func addItem()
    func enter()
    func keyboardDown()
}
