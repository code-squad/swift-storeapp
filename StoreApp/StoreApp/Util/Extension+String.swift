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

extension String {
    static let main = "main"
    static let soup = "soup"
    static let side = "side"

    // View
    static let headerView = "HeaderView"
    static let tableViewCell = "TableViewCell"

    // Section
    static let mainTitle = "메인반찬"
    static let soupTitle = "국.찌게"
    static let sideTitle = "밑반찬"

    static let mainDetail = "메인반찬 / 한그릇 뚝딱 메인 요리"
    static let soupDetail = "국.찌게 / 김이 모락모락 국.찌게"
    static let sideDetail = "밑반찬 / 언제 먹어도 든든한 밑반찬"
}

extension Int {
    var priceString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
