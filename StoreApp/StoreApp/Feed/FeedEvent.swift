//
//  FeedEvent.swift
//  StoreApp
//
//  Created by CHOMINJI on 2019/12/16.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

enum FeedEvent: String, NotificationNameable {
    case itemDidUpdated
    
    var name: NSNotification.Name {
        return NSNotification.Name(rawValue: rawValue)
    }
}
