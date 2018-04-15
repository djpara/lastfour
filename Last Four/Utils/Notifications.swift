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
let YOUR_TOTAL_DONE_PRESSED                         = "YourTotalDonePressed"
let YOUR_TOTAL_BACK_PRESSED                         = "YourTotalBackPressed"
let REQUEST_CALCULATION                             = "RequestCalculation"

// MARK: NOTIFICATION NAME EXTENSION
extension Notification.Name {
    static let pageContainerFinishedLoading         = Notification.Name(rawValue: CONTAINER_FINISHED_LOADING)
    static let layoverContainerFinishedLoading      = Notification.Name(rawValue: LAYOVER_FINISHED_LOADING)
    static let newCalculatorTypeElected             = Notification.Name(rawValue: NEW_CALCULATOR_TYPE_ELECTED)
    static let yourTotalDonePressed                 = Notification.Name(rawValue: YOUR_TOTAL_DONE_PRESSED)
    static let yourTotalBackPressed                 = Notification.Name(rawValue: YOUR_TOTAL_BACK_PRESSED)
    static let requestCalculation                   = Notification.Name(rawValue: REQUEST_CALCULATION)
}

// MARK: NOTIFICATIONS
let NOTIFICATION_PAGE_CONTAINER_FINISHED_LOADING    = Notification(name: .pageContainerFinishedLoading)
let NOTIFICATION_LAYOVER_CONTAINER_FINISHED_LOADING = Notification(name: .layoverContainerFinishedLoading)
let NOTIFICATION_NEW_CALCULATOR_TYPE_ELECTED        = Notification(name: .newCalculatorTypeElected)
let NOTIFICATION_YOUR_TOTAL_DONE_PRESSED            = Notification(name: .yourTotalDonePressed)
let NOTIFICATION_YOUR_TOTAL_BACK_PRESSED            = Notification(name: .yourTotalBackPressed)
let NOTIFICATION_REQUEST_CALCULATION                = Notification(name: .requestCalculation)
