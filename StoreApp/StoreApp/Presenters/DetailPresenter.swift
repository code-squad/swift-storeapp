//
//  DetailPresenter.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 18..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class DetailPresenter {
    weak var detailViewController: DetailViewController?
    var detailInteractor: DetailInteractor?
    
    func initViewController() {
        guard let detailInfo = detailInteractor?.detailInfo else { return }
        detailViewController?.show(with: detailInfo)
    }
}
