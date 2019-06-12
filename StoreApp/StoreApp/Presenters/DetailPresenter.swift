//
//  DetailPresenter.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 18..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class DetailPresenter {
    private weak var detailView: DetailView?
    private weak var borderColorView: BorderColorView?
    private let detailInteractor: DetailInteractor
    
    init(detailInteractor: DetailInteractor) {
        self.detailInteractor = detailInteractor
        changeBorderColor()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateStatus),
                                               name: .reachabilityChanged,
                                               object: nil)
    }
    
    @objc func updateStatus(_ noti: Notification) {
        changeBorderColor()
    }
    
    private func changeBorderColor() {
        let color: CGColor = NetworkStatus.shared.isConnected() ? #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        DispatchQueue.main.async {
            self.borderColorView?.change(borderColor: color)
        }
    }
    
    func initViewController() {
        let detailInfo = detailInteractor.detailInfo
        detailView?.show(with: detailInfo)
    }
    
    func attach(detailView: DetailView) {
        self.detailView = detailView
    }
    
    func attach(borderColorView: BorderColorView) {
        self.borderColorView = borderColorView
    }
}
