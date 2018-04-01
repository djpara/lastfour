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
let CLOSE_YOUR_TOTAL_CONTROLLER                     = "CloseYourTotalController"
let REQUEST_CALCULATION                             = "RequestCalculation"

// MARK: NOTIFICATION NAME EXTENSION
extension Notification.Name {
    static let pageContainerFinishedLoading         = Notification.Name(rawValue: CONTAINER_FINISHED_LOADING)
    static let layoverContainerFinishedLoading      = Notification.Name(rawValue: LAYOVER_FINISHED_LOADING)
    static let newCalculatorTypeElected             = Notification.Name(rawValue: NEW_CALCULATOR_TYPE_ELECTED)
    static let closeYourTotalController             = Notification.Name(rawValue: CLOSE_YOUR_TOTAL_CONTROLLER)
    static let requestCalculation                   = Notification.Name(rawValue: REQUEST_CALCULATION)
}

// MARK: NOTIFICATIONS
let NOTIFICATION_PAGE_CONTAINER_FINISHED_LOADING    = Notification(name: .pageContainerFinishedLoading)
let NOTIFICATION_LAYOVER_CONTAINER_FINISHED_LOADING = Notification(name: .layoverContainerFinishedLoading)
let NOTIFICATION_NEW_CALCULATOR_TYPE_ELECTED        = Notification(name: .newCalculatorTypeElected)
let NOTIFICATION_CLOSE_YOUR_TOTAL_CONTROLLER        = Notification(name: .closeYourTotalController)
let NOTIFICATION_REQUEST_CALCULATION                = Notification(name: .requestCalculation)
