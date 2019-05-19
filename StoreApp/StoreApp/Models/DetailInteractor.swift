//
//  DetailInteractor.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 19..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation
import JSONDataFetcher

class DetailInteractor {
    private let detailInfo: DetailInfo

    init?(hash: String) {
        guard let url = URL(string: Configuration.URL.detail + hash),
            let data = try? Data(contentsOf: url),
            let body = JSONSerialization.body(with: data, name: "data") else { return nil }
        let decoder = JSONDecoder()
        guard let detailInfo = try? decoder.decode(DetailInfo.self, from: body) else { return nil}
        self.detailInfo = detailInfo
        print(detailInfo)
    }
}
