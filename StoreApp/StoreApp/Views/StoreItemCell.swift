//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/21.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

enum Badge {
    case EventPrice, FreeGift, SpecialPrice, SoldOut, UNKNOWN
    static func fromString(_ badgeString: String) -> Badge {
        switch badgeString {
        case "이벤트특가": return .EventPrice
        case "사은품증정": return .FreeGift
        case "론칭특가": return .SpecialPrice
        case "품절": return .SoldOut
        default: return .UNKNOWN
        }
    }
}

class StoreItemCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var normalPriceLabel: UILabel!
    @IBOutlet weak var badgeStackView: UIStackView!
    
    var item: StoreItem! {
        didSet {
            self.titleLabel.text = item.title
            self.descriptionLabel.text = item.description
            rendering()
        }
    }
    
    fileprivate func rendering() {
        
        var spaceBetweenPrices = ""
        var attributedString = NSMutableAttributedString()
        
        if let normalPrice = item.nPrice {
            spaceBetweenPrices = " "
            attributedString = NSMutableAttributedString(string: normalPrice)
            attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        }
        
        attributedString.append(NSAttributedString(string: "\(spaceBetweenPrices)\(item.sPrice)", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .heavy), .foregroundColor: #colorLiteral(red: 0.1703471243, green: 0.7560165524, blue: 0.737252295, alpha: 1)]))
        self.normalPriceLabel.attributedText = attributedString
        
        badgeStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        if let badges = item.badge {
            var badgeViews = [UITextView]()
            
            badges.forEach { (badgeName) in
                let badgeTextView = CustomBadgeTextView(text: badgeName)
                badgeTextView.textColor = .white
                badgeTextView.backgroundColor = colorOfBadge(badgeName)
                badgeViews.append(badgeTextView)
            }
            
            badgeViews.forEach({ badgeStackView.addArrangedSubview($0)})
        } else {
            // trick
            badgeStackView.addArrangedSubview(CustomBadgeTextView(text: "none"))
        }
    }
    
    fileprivate func colorOfBadge(_ name: String) -> UIColor {
        var color: UIColor! = .white
        switch Badge.fromString(name) {
        case .EventPrice:
            color = UIColor(named: "BadgePurple")
        case .FreeGift:
            color = UIColor(named: "BadgeYellow")
        case .SpecialPrice:
            color = UIColor(named: "BadgePurple")
        case .SoldOut:
            color = UIColor(named: "BadgeDarkGray")
        case .UNKNOWN: break
        }
        return color
    }
    
    // init 과 awakeFromNib 차이점??
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        let itemImageViewWidth: CGFloat = 112
        itemImageView.translatesAutoresizingMaskIntoConstraints = true
        itemImageView.clipsToBounds = true
        itemImageView.frame.size = CGSize(width: itemImageViewWidth, height: itemImageViewWidth)
        itemImageView.layer.cornerRadius = itemImageViewWidth / 2
    }
}
