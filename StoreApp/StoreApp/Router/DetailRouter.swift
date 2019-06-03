//
//  DetailRouter.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 18..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class DetailRouter {
    
    private var navigationController: Navigation?
    
    init(navigationController: Navigation?) {
        self.navigationController = navigationController
    }
    
    static func assembleModule(hash: String) -> DetailViewController? {
        let storyboard = UIStoryboard(name: StoryboardNames.detailViewController,
                                      bundle: nil)
        let id = StoryboardNames.detailViewControllerID
        guard let viewController = storyboard.instantiateViewController(withIdentifier: id) as? DetailViewController,
            let interactor = DetailInteractor(hash: hash) else { return nil }
        let presenter = DetailPresenter(detailInteractor: interactor)
        viewController.detailPresenter = presenter
        
        return viewController
    }
    
    func presentViewController(detailHash: String, title: String?, delegate: DetailViewControllerDelegate) {
        guard let detailViewController = DetailRouter.assembleModule(hash: detailHash) else { return }
        self.navigationController?.push(viewController: detailViewController)
        detailViewController.titleText = title
        detailViewController.delegate = delegate
    }
}
