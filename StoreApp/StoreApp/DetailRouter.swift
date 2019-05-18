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
    
    static func assembleModule() -> UIViewController? {
        let storyboard = UIStoryboard(name: StoryboardNames.detailViewController,
                                      bundle: nil)
        guard let navigationController = storyboard.instantiateViewController(withIdentifier: StoryboardNames.detailViewNavigationControllerID) as? UINavigationController,
            let detailViewController = navigationController.topViewController as? DetailViewController else { return nil }
        
        return navigationController
    }
    
    func presentViewController(detailHash: String) {
        guard let detailViewController = DetailRouter.assembleModule() else { return }
        self.viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
