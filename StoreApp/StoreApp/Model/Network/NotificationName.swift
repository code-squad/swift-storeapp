//
//  NotificationName.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let connectionChanged = Notification.Name("connectionChanged")
    static let onReconnected = Notification.Name("onReconnected")
    static let dataLoaded = Notification.Name("dataLoaded")
}
