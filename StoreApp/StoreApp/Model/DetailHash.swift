//
//  DetailHash.swift
//  StoreApp
//
//  Created by YOUTH2 on 2018. 7. 27..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import Foundation

class DetailHash {
    let baseURL = URL(string: "http://crong.codesquad.kr:8080/woowa/detail/")!
    var url: URL
    var detailData: ItemHashData!

    init(code: String) {
        self.url = baseURL.appendingPathComponent(code)
        setDetailData()
    }

    private func setDetailData() {
        HashDataSetter.set(url: self.url) { [weak self] (itemData) in
            DispatchQueue.main.async {
                self?.detailData = itemData
            }
        }
    }
}

class HashDataSetter {

    class func set(url: URL, handler: @escaping((ItemHashData)->Void)) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Network error: \(error) \n")
            }
            if let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data {
                do {
                    let parsedData = try JSONDecoder().decode(ItemHashData.self, from: data)
                    handler(parsedData)
                    print(parsedData)
                } catch {
                    print("Parse Error!!!")
                }
            } else {
                print("Data error!")
            }
        }.resume()
    }
    
}

struct ItemHashData: Codable {
    var hash: String
    var data: DetailItemInfo
}

struct DetailItemInfo: Codable {
    var topImage: String
    var thumbImages: [String]
    var productDescription: String
    var point: String
    var deliveryInfo: String
    var deliveryFee: String
    var prices: [String]
    var detailSection: [String]

    private enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point = "point"
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices = "prices"
        case detailSection = "detail_section"
    }
}
