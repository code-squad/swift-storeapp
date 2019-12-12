//
//  StoreHeaderView.swift
//  StoreApp
//
//  Created by 이동영 on 2019/12/04.
//  Copyright © 2019 이동영. All rights reserved.
//

import UIKit
import Then
import SnapKit


class CategoryHeaderView: UITableViewHeaderFooterView {
    
    let badgeView: BadgeView = BadgeView(style: .none, text: "")
    let titleLabel: UILabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUpAttributes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpAttributes()
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        setUpConstraint()
    }
}

// MARK: - Configure

extension CategoryHeaderView {
    
    func configure(category: Category) {
        badgeView.configure(style: .none, text: category.rawValue)
        
        let description = NSMutableAttributedString(string: category.description)
        titleLabel.attributedText = description.beauty
            .align(.center)
            .font(.titleFont)
            .string
    }
}

// MARK: - Attributes & Layouts

extension CategoryHeaderView {
    
    private func setUpAttributes() {
        self.contentView.do {
            $0.addSubview(badgeView)
            $0.addSubview(titleLabel)
            $0.backgroundColor = .lightText
        }
    }
    
    private func setUpConstraint() {
        badgeView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(badgeView.snp.bottom).offset(5)
        }
    }
}

// MARK: - Reusable

extension CategoryHeaderView: Reusable {}
