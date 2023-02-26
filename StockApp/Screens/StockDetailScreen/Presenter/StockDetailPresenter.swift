//
//  StockDetailPresenter.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 16.02.2023.
//

import Foundation

protocol StockDetailViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StockDetailPresenterProtocol {
    var titleModel: DetailTitleView.TilteModel { get }
    var favoriteButtonIsSelected: Bool { get }
    
    func loadView()
    func favoriteButtonTapped()
}

final class StockDetailPresenter : StockDetailPresenterProtocol {
    private let model: StockModelProtocol
    private let service: StocksServiceProtocol
    
    weak var view: StockDetailViewProtocol?
    
    lazy var titleModel: DetailTitleView.TilteModel = {
        .from(stockModel: model)
    }()
    
    var favoriteButtonIsSelected: Bool {
        model.isFavorite
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
