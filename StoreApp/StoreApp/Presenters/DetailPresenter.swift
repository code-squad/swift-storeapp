//
//  DetailPresenter.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 18..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

class DetailPresenter {
    private weak var detailView: DetailView?
    private let detailInteractor: DetailInteractor
    
    init(detailInteractor: DetailInteractor) {
        self.detailInteractor = detailInteractor
    }
    
    func initViewController() {
        let detailInfo = detailInteractor.detailInfo
        detailView?.show(with: detailInfo)
    }
    
    func attach(detailView: DetailView) {
        self.detailView = detailView
    }
}
