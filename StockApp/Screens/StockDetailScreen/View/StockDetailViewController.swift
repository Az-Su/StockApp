//
//  StockDetailViewController.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 16.02.2023.
//

import UIKit

final class StockDetailViewController: UIViewController {
    private lazy var titleView: UIView = {
        let view = DetailTitleView()
        view.configure(with: presenter.titleModel)
        return view
    }()
    
    private let presenter: StockDetailPresenterProtocol
    
    init(presenter: StockDetailPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        setupNavigationBar()
        setupFavoriteButton()
        presenter.loadView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
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
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleView
        let backButton =  UIBarButtonItem(image: UIImage(named: "back"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(backBattonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
}

//MARK: - Button Actions

extension StockDetailViewController {
    @objc private func favoriteButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
        presenter.favoriteButtonTapped()
    }
    
    @objc
    private func backBattonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension StockDetailViewController: StockDetailViewProtocol {
    func updateView() {
        
    }
    
    func updateView(withLoader isLoading: Bool) {
        
    }
    
    func updateView(withError message: String) {
        
    }
}