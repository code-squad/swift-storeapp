//
//  Configuration.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 19..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

//MARK: - UserInfoKey
struct UserInfoKey {
    static let appendItems = "appendItems"
    static let indexPathWillReload = "indexPathWillReload"
    static let imageName = "imageName"
}

//MARK: - StoryboardNames
struct StoryboardNames {
    static let detailViewController = "DetailViewController"
    static let detailViewControllerID = "detailViewController"
}

struct Configuration {
    
    static let userName = "흥푸"
    
    //MARK: - Configuration.URL
    struct URL {
        static let storeItems = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/"
        static let detail = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail/"
    }
}
