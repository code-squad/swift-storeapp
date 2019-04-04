//
//  MyCustomHeader.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 28..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit

class MyCustomHeader : UITableViewHeaderFooterView {
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerText: UILabel!
    
    
}

extension UIView {
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}
