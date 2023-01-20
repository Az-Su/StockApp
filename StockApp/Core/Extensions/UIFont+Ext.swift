//
//  UIFont.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 18.01.2023.
//

import Foundation
import UIKit

extension UIFont {
    static func regular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Montserrat-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
    
    static func bold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Montserrat-Bold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
    
    static func medium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Montserrat-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
    
    static func semiBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Montserrat-SemiBold", size: size) else {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
        return font
    }
}
