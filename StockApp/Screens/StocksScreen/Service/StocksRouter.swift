//
//  StocksRouter.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 01.02.2023.
//

import Foundation

enum StocksRouter: Router {
    case stocks(currency: String, count: String)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
            return "/api/v3/coins/markets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let currency, let count):
            return ["vs_currency": currency, "per_page": count]
        }
    }
}

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
}

final class StocksService: StocksServiceProtocol {
    private let client: NetworkService
    
    init (client: NetworkService) {
        self.client = client
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
}
