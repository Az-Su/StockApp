//
//  Assembly.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 02.02.2023.
//

import Foundation
import UIKit


final class Assembly {
    static let assembler: Assembly = .init()
    let favoritesService: FavoriteServiceProtocol = FavoriteLocalService()

    
    private init() {}
    
    private lazy var network: NetworkService = Network()

    
    private lazy var stocksService: StocksServiceProtocol = StocksService(network: network)
    private lazy var chartsService: ChartsServiceProtocol = ChartsService(network: network)
    
    
    private func stocksModule() -> UIViewController {
        let presenter = StocksPresenter(service: stocksService)
        let view = StocksViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    private func favoriteModule() -> UIViewController {
        let presenter = FavoritePresenter(service: stocksService)
        let favoritesVC = FavoriteViewController(presenter: presenter)
        presenter.view = favoritesVC
        return favoritesVC
    }
    
    func tabBarController() -> UIViewController {
        let tabBar = UITabBarController()
        
        let stocksVC = UINavigationController(rootViewController: stocksModule())
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(named: "diagram"), tag: 0)
        
        let favoriteVC = UINavigationController(rootViewController: favoriteModule())
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favorite"), tag: 1)
        
        let searchVC = UINavigationController(rootViewController: stocksModule())
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search") , tag: 2)
        
        tabBar.viewControllers = [stocksVC, favoriteVC, searchVC]
        tabBar.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)
        tabBar.tabBar.barTintColor = .backgroundGray
        tabBar.tabBar.backgroundColor = .backgroundGray
        return tabBar
    }
    
    func detailVC(for model: StockModelProtocol) -> UIViewController {
        let presenter = StockDetailPresenter(model: model, service: chartsService)
        let view = StockDetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
