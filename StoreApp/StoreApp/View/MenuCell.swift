//
//  StoreItemCell.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import Then

final class MenuCell: UITableViewCell, Reusable {
    
    // MARK: - UI
    
    private let menuImageView = UIImageView()
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let priceLabel = UILabel()
    private let salePriceLabel = UILabel()
    private let badgesListView = BadgeListView()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpAttributes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpAttributes()
    }
    
    // MARK: - Life Cycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setUpConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clear()
    }
}

// MARK: - Configure

extension MenuCell {
    
    func configure(_ menu: Menu) {
        if let price = menu.price {
            let price = NSMutableAttributedString(string: price)
            price.beauty.align(.center).strikethrough(1)
            priceLabel.attributedText = price
        }
        
        menu.badge?.compactMap {
            let style = BadgeView.Style($0)
            return BadgeView(style: style, text: $0)
        }
        .forEach { badgesListView.addSubview($0) }
        
        menu.do {
            titleLabel.text = $0.title
            detailLabel.text = $0.detail
            salePriceLabel.text = $0.salePrice
        }
    }
    
    private func clear() {
        menuImageView.image = nil
        titleLabel.text = nil
        detailLabel.text = nil
        priceLabel.attributedText = nil
        salePriceLabel.text = nil
        badgesListView.subviews.forEach { $0.removeFromSuperview() }
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
            $0.addSubview(salePriceLabel)
            $0.addSubview(badgesListView)
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
        
        salePriceLabel.do {
            $0.font = .discountedPriceFont
            $0.textColor = .mint
        }
    }
    
    private func setUpConstraints() {
        menuImageView.snp.updateConstraints {
            $0.width.equalToSuperview().dividedBy(4)
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(menuImageView.snp.width)
        }
        
        titleLabel.snp.updateConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(menuImageView.snp.trailing).offset(10)
            $0.height.equalTo(menuImageView.snp.height).dividedBy(5)
        }
        
        detailLabel.snp.updateConstraints {
            $0.leading.height.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        priceLabel.snp.updateConstraints {
            $0.leading.equalTo(titleLabel)
            $0.height.equalTo(titleLabel)
            $0.top.equalTo(detailLabel.snp.bottom).offset(4)
        }
        
        salePriceLabel.snp.updateConstraints {
            $0.leading.equalTo(priceLabel.snp.trailing)
                .offset(priceLabel.text == nil ? 0 : 10)
            $0.height.equalTo(titleLabel)
            $0.top.equalTo(detailLabel.snp.bottom).offset(4)
        }
        
        badgesListView.snp.updateConstraints {
            $0.height.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(priceLabel.snp.bottom).offset(5)
        }
    }
}
