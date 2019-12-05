//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit

final class MenuCell: UITableViewCell {

    // MARK: - UI
    
    private let menuImageView = UIImageView()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let priceLabel = UILabel()
    private let discountedPriceLabel = UILabel()
    private let badgesStackView = UIStackView()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func updateConstraints() {
        super.updateConstraints()
        
        setUpConstraints()
    }
}

// MARK: - Configure

extension MenuCell {
    
    func configure() {
        
    }
}

// MARK: - Attributes & Layouts

extension MenuCell {
    
    private func setUpAttributes() {
        self.contentView.do {
            $0.addSubview(menuImageView)
            $0.addSubview(titleLabel)
            $0.addSubview(detailLabel)
            $0.addSubview(priceLabel)
            $0.addSubview(discountedPriceLabel)
            $0.addSubview(badgesStackView)
        }
        
        titleLabel.do {
            $0.font = .titleFont
        }
        
        detailLabel.do {
            $0.font = .detailFont
            $0.textColor = .lightGray
        }
        
        priceLabel.do {
            $0.font = .priceFont
            $0.textColor = .lightGray
        }
        
        discountedPriceLabel.do {
            $0.font = .discountedPriceFont
            $0.textColor = .mint
        }
    }
    
}
