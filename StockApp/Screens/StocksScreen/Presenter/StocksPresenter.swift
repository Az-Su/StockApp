//
//  StocksPresenter.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 02.02.2023.
//

import Foundation
import UIKit

//AnyObject only for reference type
protocol StocksViewProtocol: AnyObject {
    func updateView()
    func updateCell(for indexPath: IndexPath)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StocksPresenterProtocol {
    var view: StocksViewProtocol? { get set }
    var itemsCount: Int { get }
    
    //Load presenter after view are loaded
    func loadView()
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class StocksPresenter: StocksPresenterProtocol {
    private let service: StocksServiceProtocol
    private var stocks: [StockModelProtocol] = []
    
    var itemsCount: Int {
        stocks.count
    }
    
    init(service: StocksServiceProtocol, view: StocksViewProtocol? = nil) {
        self.service = service
    }
    
    weak var view: StocksViewProtocol?
    
    func loadView() {
        startFavoritesNotificationObserving()
        
        // Show loader
        view?.updateView(withLoader: true)
        
        service.getStocks { [weak self] result in
            //Come back with data and hide loader
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let stocks):
                self?.stocks = stocks.map { StockModel(stock: $0) }
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        stocks[indexPath.row]
    }
}

extension StocksPresenter: FavoriteUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        guard let id = notification.stockId,
              let index = stocks.firstIndex(where: { $0.id == id }) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        view?.updateCell(for: indexPath)
        
    }
    
    
}
