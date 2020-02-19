//
//  Notifications.swift
//  Last Four
//
//  Created by David Para on 3/23/18.
//  Copyright © 2018 parad. All rights reserved.
//

import Foundation

// MARK: CONTRACTED_OBJECTS
let notificationCenterDefault = NotificationCenter.default

// MARK: NOTIFICATION RAW VALUE
let CONTAINER_FINISHED_LOADING                      = "ContainerFinishedLoading"
let LAYOVER_FINISHED_LOADING                        = "LayoverFinishedLoading"
let NEW_CALCULATOR_TYPE_ELECTED                     = "NewCalculatorTypeElected"
let YOUR_TOTAL_BACK_PRESSED                         = "YourTotalBackPressed"
let REQUEST_CALCULATION                             = "RequestCalculation"
let SIMPLE_TIP                                      = "SimpleTip"
let RESET                                           = "Reset"

// MARK: NOTIFICATION NAME EXTENSION
extension Notification.Name {
    static let pageContainerFinishedLoading         = Notification.Name(rawValue: CONTAINER_FINISHED_LOADING)
    static let layoverContainerFinishedLoading      = Notification.Name(rawValue: LAYOVER_FINISHED_LOADING)
    static let newCalculatorTypeElected             = Notification.Name(rawValue: NEW_CALCULATOR_TYPE_ELECTED)
    static let yourTotalBackPressed                 = Notification.Name(rawValue: YOUR_TOTAL_BACK_PRESSED)
    static let requestCalculation                   = Notification.Name(rawValue: REQUEST_CALCULATION)
    static let showSimpleTip                        = Notification.Name(rawValue: SIMPLE_TIP)
    static let reset                                = Notification.Name(rawValue: RESET)
}

// MARK: NOTIFICATIONS
let NOTIFICATION_PAGE_CONTAINER_FINISHED_LOADING    = Notification(name: .pageContainerFinishedLoading)
let NOTIFICATION_LAYOVER_CONTAINER_FINISHED_LOADING = Notification(name: .layoverContainerFinishedLoading)
let NOTIFICATION_NEW_CALCULATOR_TYPE_ELECTED        = Notification(name: .newCalculatorTypeElected)
let NOTIFICATION_YOUR_TOTAL_BACK_PRESSED            = Notification(name: .yourTotalBackPressed)
let NOTIFICATION_REQUEST_CALCULATION                = Notification(name: .requestCalculation)
let NOTIFICATION_SHOW_SIMPLE_TIP                    = Notification(name: .showSimpleTip)
let NOTIFICATION_RESET                              = Notification(name: .reset)
