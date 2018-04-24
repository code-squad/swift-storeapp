//
//  MenuImage.swift
//  StoreApp
//
//  Created by TaeHyeonLee on 2018. 4. 24..
//  Copyright © 2018년 ChocOZerO. All rights reserved.
//

import UIKit

class MenuImage: Decodable {
    private let urlString: String
    private let row: Int
    private let section: Int
    var image: UIImage? {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: .image,
                    object: self,
                    userInfo: ["row": self.row, "section": self.section])
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case urlString
        case row
        case section
    }

    init(urlString: String, row: Int, section: Int) {
        self.urlString = urlString
        self.row = row
        self.section = section
        self.image = loadImage()

    }

    private func loadImage() -> UIImage? {
        guard let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
            else { return nil }
        guard let imageURL = URL(string: urlString) else { return nil }
        let fileURL = cacheURL.appendingPathComponent(imageURL.lastPathComponent)
        if FileManager.default.fileExists (atPath: fileURL.path) {
            return UIImage(named: fileURL.path)
        } else {
            downLoadImage(from: imageURL, to: fileURL)
            return nil
        }
    }

    private func downLoadImage(from imageURL: URL, to fileURL: URL) {
        URLSession.shared.downloadTask(with: imageURL, completionHandler: { (url, urlResponse, error) in
            if let url = url {
                try? FileManager.default.moveItem(at: url, to: fileURL)
                self.image = UIImage(named: fileURL.path)
            }
        }).resume()
    }
}
