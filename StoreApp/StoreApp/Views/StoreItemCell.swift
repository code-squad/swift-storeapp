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
            
            // attributeString for priceLabels
            var spaceBetweenPrices = ""
            
            var attributedString = NSMutableAttributedString()
            if let normalPrice = item.nPrice {
                spaceBetweenPrices = "  "
                attributedString = NSMutableAttributedString(string: normalPrice)
                attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            }
            attributedString.append(NSAttributedString(string: "\(spaceBetweenPrices)\(item.sPrice)", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .heavy), .foregroundColor: #colorLiteral(red: 0.1703471243, green: 0.7560165524, blue: 0.737252295, alpha: 1)]))
            self.normalPriceLabel.attributedText = attributedString
            
            if let badges = item.badge {
                var badgeViews = [UITextView]()
                
                badges.forEach { (badgeString) in
                    let badgeTextView = CustomBadgeTextView(text: badgeString)
                    
                    switch Badge.fromString(badgeString) {
                    case .EventPrice:
                        badgeTextView.backgroundColor = #colorLiteral(red: 0.6633180976, green: 0.4506880641, blue: 0.7471640706, alpha: 1)
                    case .FreeGift:
                        badgeTextView.backgroundColor = #colorLiteral(red: 0.9738679528, green: 0.7125977874, blue: 0, alpha: 1)
                    case .SpecialPrice:
                        badgeTextView.backgroundColor = #colorLiteral(red: 0.6633180976, green: 0.4506880641, blue: 0.7471640706, alpha: 1)
                    case .SoldOut:
                        badgeTextView.backgroundColor = #colorLiteral(red: 0.1999788582, green: 0.2000134587, blue: 0.1999712586, alpha: 1)
                    case .UNKNOWN: break
                    @unknown default: break
                    }
                    
                    badgeViews.append(badgeTextView)
                }
                badgeStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
                badgeViews.forEach({ badgeStackView.addArrangedSubview($0)})
            } else {
                badgeStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
                badgeStackView.addArrangedSubview(CustomBadgeTextView(text: "none"))
            }
        }
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
