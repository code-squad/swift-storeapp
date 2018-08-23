//
//  ItemCell.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 13..
//  Copyright © 2018년 김수현. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var nPrice: UILabel!
    @IBOutlet weak var sPrice: UILabel!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    func set(_ item: StoreItem) {
        itemTitle.text = item.title
        itemDescription.text = item.description
        sPrice.text = item.sPrice
        fetchItemImages(item.image)
        
        if let price = item.nPrice {
            nPrice.text = price
            nPrice.isHidden = false
        } else {
            nPrice.isHidden = true
        }
        
        guard let badges = item.badge else { return }

        for badge in badges {
            let newBadge = UILabel(frame: .zero)
            newBadge.text = badge
            newBadge.backgroundColor = .purple
            newBadge.textColor = .white
            badgeStackView.addArrangedSubview(newBadge)
        }
        
    }
    
    private func fetchItemImages(_ imageURL: String) {
        guard let fileURL = makeImageURL(imageURL) else { return }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            guard let data = loadImageData(fileURL) else { return }
            self.itemImage.image = UIImage(data: data)
        } else { //파일이 없을경우 파일 생성후 데이터 저장
            DispatchQueue.global().async {
                guard let data = self.saveImageData(imageURL, fileURL) else { return }
                DispatchQueue.main.async {
                    self.itemImage.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func makeImageURL(_ imageURL: String) -> URL? {
        
        //urls(for:in:) 메소드를 통해 특정 경로에 접근한 후 추가 경로를 cachesDirectory로 지정
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        guard let url = URL(string: imageURL) else { return nil }
        
        //imageURL에서 경로 /구분자를 이용해 문자열을 분리한 후 마지막 문자열을 기존의 경로에 추가
        let fileURL = path.appendingPathComponent(url.lastPathComponent)
        
        return fileURL
    }
    
    private func loadImageData(_ url: URL) -> Data? {
        return FileManager.default.contents(atPath: url.path)
    }
    
    private func saveImageData(_ imageURL: String,_ fileURL: URL) -> Data? {
        guard let url = URL(string: imageURL) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        return data
    }

    override func prepareForReuse() {
        self.badgeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
}
