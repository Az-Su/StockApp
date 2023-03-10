//
//  SearchService.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 08.03.2023.
//

import Foundation

protocol SearchServiceProtocol {
    func getFilterStocks(by text: String?) -> [StockModelProtocol]
}

final class SearchService: SearchServiceProtocol {
    private let service: StocksServiceProtocol
    
    init(service: StocksServiceProtocol) {
       self.service = service
   }
    
    func getFilterStocks(by text: String?) -> [StockModelProtocol] {
        guard let text = text,
              !text.isEmpty else {
            return service.getStocks()
        }
        return service.getStocks().filter {$0.symbol.lowercased().contains(text.lowercased())}
    }
}
