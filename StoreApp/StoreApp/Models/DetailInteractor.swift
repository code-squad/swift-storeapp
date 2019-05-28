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
    let detailInfo: DetailInfo

    init?(hash: String) {
        guard let url = URL(string: Configuration.URL.detail + hash),
            let data = try? Data(contentsOf: url) else { return nil }
        let decoder = JSONDecoder()
        guard let detailJSON = try? decoder.decode(DetailJSON.self, from: data) else { return nil}
        self.detailInfo = detailJSON.data
    }
}
