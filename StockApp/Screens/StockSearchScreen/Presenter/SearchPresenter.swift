//
//  SearchPresenter.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 08.03.2023.
//

import Foundation


protocol SearchTextFiledDelegate: AnyObject {
    func textDidChange(to text: String?)
}

protocol SearchStocksPresenterProtocol: SearchTextFiledDelegate {
    var viewController: StocksViewProtocol? { get set }
    var itemCount: Int { get }
    var savedSearches: [String] { get set }
    
    func loadView()
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class SearchPersenter: SearchStocksPresenterProtocol {
    private let searchService:  SearchServiceProtocol
    private var filteredStocks: [StockModelProtocol] = []
    weak var viewController: StocksViewProtocol?
    var savedSearches: [String] = []
    
    init(service: SearchServiceProtocol) {
        self.searchService = service
        startFavoritesNotificationObserving()
    }
    
    var itemCount: Int {
        filteredStocks.count
    }
    
    func loadView() {
        filteredStocks = searchService.getFilterStocks(by: nil)
        viewController?.updateView()
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        filteredStocks[indexPath.row]
    }
}

extension SearchPersenter: FavoriteUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        guard let id = notification.stockId,
              let index = filteredStocks.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        viewController?.updateCell(for: IndexPath(row: index, section: 0))
    }
}

extension SearchPersenter: SearchTextFiledDelegate {
    func textDidChange(to text: String?) {
        filteredStocks = searchService.getFilterStocks(by: text)
        viewController?.updateView()
    }
}

