//
//  SceneDelegate.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import Then

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = .white
        
        let service: DataServable = StubDataService()
        let viewModel: StoreListViewBindable = StoreListViewModel(service: service)
        let viewController: StoreListViewPresentable = StoreListViewController()
        
        window?.rootViewController = viewController.then { $0.viewModel = viewModel }
        window?.makeKeyAndVisible()
    }
}

