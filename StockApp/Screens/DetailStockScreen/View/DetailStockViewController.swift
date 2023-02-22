//
//  DetailStockViewController.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 16.02.2023.
//

import UIKit

final class DetailStockViewController: UIViewController {
    private let presenter: DetailStockPresenterProtocol
    
    init(presenter: DetailStockPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = presenter.title
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupFavoriteButton()
        presenter.loadView()
    }
    
    private func setupFavoriteButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "Path"), for: .normal)
        button.setImage(UIImage(named: "Path2"), for: .selected)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.isSelected = presenter.favoriteButtonIsSelected
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
}

//MARK: - Button Actions

extension DetailStockViewController {
    @objc private func favoriteButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        presenter.favoriteButtonTapped()
    }
}

extension DetailStockViewController: DetailStockViewProtocol {
    func updateView() {
        
    }
    
    func updateView(withLoader isLoading: Bool) {
        
    }
    
    func updateView(withError message: String) {
        
    }
    
    
}
