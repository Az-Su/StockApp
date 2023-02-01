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
    
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        
        let stocksVC = UINavigationController(rootViewController: StocksViewController())
        stocksVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "diagram"), tag: 0)
        
        let favoriteVC = UINavigationController(rootViewController: StocksViewController())
        favoriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "favorite"), tag: 1)
        
        let searchVC = UINavigationController(rootViewController: StocksViewController())
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "search") , tag: 2)
        
        tabbar.viewControllers = [stocksVC, favoriteVC, searchVC]
        tabbar.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)
        tabbar.tabBar.barTintColor = .backgroundGray
        tabbar.tabBar.backgroundColor = .backgroundGray
        return tabbar
    }
}
