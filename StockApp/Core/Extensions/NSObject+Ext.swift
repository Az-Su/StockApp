//
//  NSObject+Ext.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 18.01.2023.
//

import Foundation


extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}
