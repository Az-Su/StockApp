//
//  Double+Ext.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 05.02.2023.
//

import Foundation

extension Double {
    static func checkDecimal(check: Double?) -> String {
        let res: String
        guard let value = check else { return "" }
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            res = "\(Int(value))"
        } else {
            res = "\(ceil(value * 10000) / 10000)"
        }
        return res
    }
}
