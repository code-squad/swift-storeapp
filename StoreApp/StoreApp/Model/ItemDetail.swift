//
//  ItemDetail.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 28..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

class ItemDetail: Decodable {
    
    private var title: String!
    private var hash: String!
    private var data: DetailData!
    
    init(_ itemDetailTitle: String, _ itemHash: String) {
        title = itemDetailTitle
        guard let url = URL(string: Keyword.ItemDetail.base.URL + itemHash) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let itemDetail = self.decode(data) else { return }
                self.hash = itemDetail.hash
                self.data = itemDetail.data
                NotificationCenter.default.post(name: .loadDetailData, object: self, userInfo: [Keyword.Observer.detailData.name: self.data, Keyword.Observer.itemDetailTitle.name: self.title])
                self.loadThumbnailData()
                self.loadDetailSectionData()
            }
            }.resume()
    }
    
    private func decode(_ data : Data) -> ItemDetail? {
        do {
            return try JSONDecoder().decode(ItemDetail.self, from : data)
        } catch {
            return nil
        }
    }
    
    private func loadThumbnailData() {
            for URLindex in 0..<data.thumb_images.count {
                Downloader.loadURLImage(data.thumb_images[URLindex]) { (result) in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .thumbnail, object: self,
                                                            userInfo: [Keyword.Observer.thumbnailData.name : (data: data, index: URLindex)])
                        }
                    case .failure(): break
                    }
                }
            }
    }
    
    private func loadDetailSectionData() {
            for URLindex in 0..<data.detail_section.count {
                Downloader.loadURLImage(data.detail_section[URLindex]) { (result) in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .detailSection, object: self,
                                                            userInfo: [Keyword.Observer.detailSectionData.name : (data: data, index: URLindex)])
                        }
                    case .failure(): break
                    }
                }
        }
    }
}
