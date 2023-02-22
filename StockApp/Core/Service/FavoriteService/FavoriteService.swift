//
//  FavoriteService.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 15.02.2023.
//

import Foundation

protocol FavoriteServiceProtocol {
    func save(id: String)
    func remove(id: String)
    func isFavorite(for id: String) -> Bool
}
