//
//  DetailRouter.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 18..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class DetailRouter {
    
    weak var viewController: StoreTableViewController?
    
    init(storeViewController: StoreTableViewController?) {
        self.viewController = storeViewController
    }
    
    static func assembleModule(hash: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: StoryboardNames.detailViewController,
                                      bundle: nil)
        let id = StoryboardNames.detailViewControllerID
        guard let viewController = storyboard.instantiateViewController(withIdentifier: id) as? DetailViewController,
            let interactor = DetailInteractor(hash: hash) else { return nil }
        let presenter = DetailPresenter()
        viewController.detailPresenter = presenter
        presenter.detailViewController = viewController
        presenter.detailInteractor = interactor
        
        return viewController
    }
    
    func presentViewController(detailHash: String) {
        guard let detailViewController = DetailRouter.assembleModule(hash: detailHash) else { return }
        self.viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
