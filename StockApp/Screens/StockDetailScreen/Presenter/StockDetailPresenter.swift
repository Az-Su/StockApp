//
//  StockDetailPresenter.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 16.02.2023.
//

import Foundation
import UIKit

protocol StockDetailViewProtocol: AnyObject {
    func updateView(withChartModel chartModel: DetailModel)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StockDetailPresenterProtocol {
    var titleModel: DetailTitleView.TitleModel { get }
    var favoriteButtonIsSelected: Bool { get }
    var price: String { get }
    var percent: String { get }
    var change: UIColor { get }
    
    func loadView()
    func favoriteButtonTapped()
}

final class StockDetailPresenter : StockDetailPresenterProtocol {
    private let model: StockModelProtocol
    private let service: ChartsServiceProtocol
    
    var price: String {
        model.price
    }
    var percent: String{
        model.change
    }
    var change: UIColor{
        model.changeColor
    }
    
    weak var view: StockDetailViewProtocol?
    
    lazy var titleModel: DetailTitleView.TitleModel = {
        .from(stockModel: model)
    }()
    
    var favoriteButtonIsSelected: Bool {
        model.isFavorite
    }
    
    init(model: StockModelProtocol, service: ChartsServiceProtocol) {
        self.model = model
        self.service = service
    }
    
    func loadView() {
        view?.updateView(withLoader: true)
        
        service.getCharts(id: model.id ) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let charts):
                let DetailModel = DetailModel.build(from: charts)
                self?.view?.updateView(withChartModel: DetailModel)
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func favoriteButtonTapped() {
        model.setFavorite()
    }
}
