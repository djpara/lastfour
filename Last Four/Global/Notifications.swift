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

// MARKL NOTIFICATIONS
let NOTIFICATION_CONTAINER_FINISHED_LOADING = Notification(name: .containerFinishedLoading)
let NOTIFICATION_NEW_CALCULATOR_TYPE_ELECTED = Notification(name: .newCalculatorTypeElected)

// MARK: NOTIFICATION NAME EXTENSION
extension Notification.Name {
    static let containerFinishedLoading = Notification.Name(rawValue: "ContainerFinishedLoading")
    static let newCalculatorTypeElected = Notification.Name(rawValue: "NewCalculatorTypeElected")
}

