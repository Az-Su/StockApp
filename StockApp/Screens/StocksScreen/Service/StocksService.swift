//
//  StocksRouter.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 01.02.2023.
//

import Foundation

fileprivate enum Constants {
    static let currency = "usd"
    static let count = "100"
}

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getFavoriteStocks() -> [StockModelProtocol]
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks() -> [StockModelProtocol]

}

final class StocksService: StocksServiceProtocol {
    private let client: NetworkService
    private var stocksModels: [StockModelProtocol] = []

    
    init (client: NetworkService) {
        self.client = client
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
    
    private func stockModels(for stocks: [Stock]) -> [StockModelProtocol] {
        stocksModels = stocks.map { StockModel(stock: $0) }
        return stocksModels
    }
    
    func getFavoriteStocks() -> [StockModelProtocol] {
        stocksModels.filter {$0.isFavorite}
    }
    
    func getStocks() -> [StockModelProtocol] {
        stocksModels
    }
    
    func getCharts(id: String, currency: String, days: String, isDaily: Bool, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.charts(id: id, currency: currency, days: days, isDaily: isDaily), completion: completion)
    }
}

extension StocksServiceProtocol {
    func getStocks(currency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: currency, count: Constants.count, completion: completion)
    }
    
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: Constants.currency, completion: completion)
    }
}
