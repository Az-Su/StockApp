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
    private init() {}
    
    private lazy var network: NetworkService = Network()
    private lazy var stocksService: StocksServiceProtocol = StocksService(client: network)
    
    let favoritesService: FavoriteServiceProtocol = FavoriteLocalService()
    
    private func stocksModule() -> UIViewController {
        let presenter = StocksPresenter(service: stocksService)
        let view = StocksViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
    func tabBarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let stocksVC = UINavigationController(rootViewController: stocksModule())
        stocksVC.tabBarItem = UITabBarItem(title: "Stocks", image: UIImage(named: "diagram"), tag: 0)
        
        let favoriteVC = UINavigationController(rootViewController: stocksModule())
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favorite"), tag: 1)
        
        let searchVC = UINavigationController(rootViewController: stocksModule())
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search") , tag: 2)
        
        tabbar.viewControllers = [stocksVC, favoriteVC, searchVC]
        tabbar.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)
        tabbar.tabBar.barTintColor = .backgroundGray
        tabbar.tabBar.backgroundColor = .backgroundGray
        return tabbar
    }
    
    func detailVC(for model: StockModelProtocol) -> UIViewController {
        let presenter = StockDetailPresenter(model: model, service: stocksService)
        let view = StockDetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
