//
//  CustomBadgeTextView.swift
//  StoreApp
//
//  Created by Cory Kim on 2019/10/22.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

class CustomBadgeTextView: UITextView {

    init(text: String) {
        super.init(frame: .zero, textContainer: nil)
        customIntializer(text: text)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        customIntializer(text: "NONE")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customIntializer(text: "NONE")
    }
    
    func customIntializer(text: String) {
        self.text = text
        textAlignment = .center
        isScrollEnabled = false
        isEditable = false
        isSelectable = false
        font = .systemFont(ofSize: 14)
        textColor = UIColor(named: "BadgeWhite")
        backgroundColor = UIColor(named: "BadgeWhite")
        textContainerInset = .init(top: 2, left: 2, bottom: 2, right: 2)
        sizeToFit()
    }
}
