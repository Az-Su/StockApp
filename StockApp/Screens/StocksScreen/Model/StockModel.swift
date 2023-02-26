//
//  StockModel.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 05.02.2023.
//

import Foundation
import UIKit

protocol StockModelProtocol {
    var id: String { get }
    var name: String { get }
    var iconURL: String { get }
    var symbol: String { get }
    var price: String { get }
    var change: String { get }
    var changeColor: UIColor { get }
    
    var isFavorite: Bool { get set }
    
    func setFavorite()
}

final class StockModel: StockModelProtocol {
    private let stock: Stock
    private let favoriteService: FavoriteServiceProtocol
    
    init(stock: Stock) {
        self.stock = stock
        favoriteService = Assembly.assembler.favoritesService
        isFavorite = favoriteService.isFavorite(for: id)
    }
    
    var id: String {
        stock.id
    }
    
    var name: String {
        stock.name
    }
    
    var iconURL: String {
        stock.image
    }
    
    var symbol: String {
        stock.symbol
    }
    
    var price: String {
        "$" + Double.checkDecimal(check: stock.price)
    }
    
    var change: String {
        if stock.change >= 0.0 {
            return "+" + "$" + Double.checkDecimal(check: stock.change)
            
        } else {
            return  "$" + Double.checkDecimal(check: stock.change)
        }
    }
    
    var changeColor: UIColor {
        stock.change >= 0 ? .backgroundGreen : .red
        
    }
    
    var isFavorite: Bool = false
    
    func setFavorite() {
        isFavorite.toggle()
        
        if isFavorite {
            favoriteService.save(id: id)
        } else {
            favoriteService.remove(id: id)
        }
    }
}
