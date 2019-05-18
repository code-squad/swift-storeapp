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
        let id = StoryboardNames.detailViewControllerID
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: id) as? DetailViewController else { return nil }
        
        return detailViewController
    }
    
    func presentViewController(detailHash: String) {
        guard let detailViewController = DetailRouter.assembleModule() else { return }
        self.viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
