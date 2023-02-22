//
//  DetailStockPresenter.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 16.02.2023.
//

import Foundation

protocol DetailStockViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol DetailStockPresenterProtocol {
    var favoriteButtonIsSelected: Bool { get }
    var title: String? { get }
    
    func loadView()
    func favoriteButtonTapped()
}

final class DetailStockPresenter : DetailStockPresenterProtocol {
    private let model: StockModelProtocol
    private let service: StocksServiceProtocol
    
    weak var view: DetailStockViewProtocol?
    
    var favoriteButtonIsSelected: Bool {
        model.isFavorite
    }
    
    var title: String? {
        model.name
    }
    
    init(model: StockModelProtocol, service: StocksServiceProtocol) {
        self.model = model
        self.service = service
    }
    
    func loadView() {
        view?.updateView(withLoader: true)
        
        service.getCharts(id: model.id, currency: "usd", days: "100", isDaily: true) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let charts):
                self?.view?.updateView()
                print("Charts count - ", charts)
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func favoriteButtonTapped() {
        model.setFavorite()
    }
}
