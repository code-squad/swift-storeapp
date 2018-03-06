//
//  DetailData.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 5..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

struct DetailData: Decodable {
    let topImage: String
    let thumbnailUrls: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSectionUrls: [String]
    var thumbnails: [UIImage]
    var detailSectionItems: [UIImage]

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.topImage = try values.decode(String.self, forKey: .topImage)
        self.thumbnailUrls = try values.decode([String].self, forKey: .thumbImages)
        self.productDescription = try values.decode(String.self, forKey: .productDescription)
        self.point = try values.decode(String.self, forKey: .point)
        self.deliveryInfo = try values.decode(String.self, forKey: .deliveryInfo)
        self.deliveryFee = try values.decode(String.self, forKey: .deliveryFee)
        self.prices = try values.decode([String].self, forKey: .prices)
        self.detailSectionUrls = try values.decode([String].self, forKey: .detailSection)
        self.thumbnails = []
        self.detailSectionItems = []
        self.thumbnails = try loadImages(thumbnailUrls)
        self.detailSectionItems = try loadImages(detailSectionUrls)
    }

    private func loadImages(_ urlStrings: [String]) throws -> [UIImage] {
        return try urlStrings.flatMap { urlString -> UIImage? in
            guard let url = URL(string: urlString) else { return nil }
            return UIImage(data: try Data(contentsOf: url))
        }
    }

    enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSection = "detail_section"
    }
}
