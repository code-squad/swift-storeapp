//
//  ItemCell.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

// 커스텀 셀 클래스 (뷰)
class ItemCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var pricesContainer: PricesContainer!
    @IBOutlet weak var badges: BadgesContainer?

    override func awakeFromNib() {
        self.thumbnail.tag = Tag.thumbnail.rawValue
        self.title.tag = Tag.title.rawValue
        self.titleDescription.tag = Tag.titleDescription.rawValue
        self.badges?.tag = Tag.badges.rawValue
        configure()
    }

    enum Tag: Int {
        case thumbnail = 0
        case title
        case titleDescription
        case badges

        static let elements: [Tag] = [Tag.thumbnail, .title, .titleDescription, .badges]
    }
}

extension ItemCell: StyleConfigurable {

    func configure() {
        Tag.elements.forEach {
            if let labelPresentable = labelProperties($0) {
                guard let element = viewWithTag($0.rawValue) as? UILabel else { return }
                configure(label: element, style: labelPresentable)
            }
        }
    }

    func labelProperties(_ tag: Tag) -> UILabelPresentable? {
        switch tag {
        case .title: return Style.Title()
        case .titleDescription: return Style.Description()
        default: return nil
        }
    }

}
