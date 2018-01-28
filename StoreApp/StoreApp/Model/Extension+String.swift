//
//  Extension+String.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 28..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import Foundation

extension String {
    var number: Int {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let priceString = self.extractString(except: "원")
        guard let number = formatter.number(from: priceString) else { return 0 }
        return number.intValue
    }

    func extractString(except measure: String) -> String {
        let startMeasureCharacter = self.index(self.endIndex, offsetBy: (measure.count * (-1)))
        let range = startMeasureCharacter...self.index(before: self.endIndex)
        if self[range] != measure {
            return self
        }
        return String(self[self.startIndex...self.index(before: startMeasureCharacter)])
    }
}
