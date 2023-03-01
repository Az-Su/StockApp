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
    
    private lazy var chartsContainerView: ChartsContainerView = {
        let view = ChartsContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(size: 28)
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = .semiBold(size: 12)
        label.textColor = UIColor.backgroundGreen
        return label
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buy for", for: .normal)
        button.titleLabel?.font = .semiBold(size: 16)
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, percentLabel])
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private let presenter: StockDetailPresenterProtocol
    
    override var hidesBottomBarWhenPushed: Bool {
        get { true }
        set { super.hidesBottomBarWhenPushed = newValue }
    }
    
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
        setupConstraints()
        setupNavigationBar()
        setupFavoriteButton()
        presenter.loadView()
    }
}

//MARK: - Setup methods

private extension StockDetailViewController {
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(priceStackView)
        view.addSubview(chartsContainerView)
        view.addSubview(buyButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            chartsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartsContainerView.topAnchor.constraint(equalTo: priceStackView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            priceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceStackView.bottomAnchor.constraint(equalTo: chartsContainerView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: chartsContainerView.bottomAnchor,constant: 50),
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            buyButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupFavoriteButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "Path"), for: .normal)
        button.setImage(UIImage(named: "Path2"), for: .selected)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.isSelected = presenter.favoriteButtonIsSelected
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
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
    private func buyButtonTapped(_ sender: UIButton){
        let alertController = UIAlertController(title: "Purchase", message: "🎉The purchase is successful🎉", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alertController.addAction(action)
        self.present(alertController, animated: true,completion: nil)
    }
    
    @objc
    private func backBattonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension StockDetailViewController: StockDetailViewProtocol {    
    func updateView(withChartModel detailModel: DetailModel) {
        chartsContainerView.configure(with: detailModel)
        priceLabel.text = presenter.price
        percentLabel.text = presenter.percent
        percentLabel.textColor = presenter.change
        buyButton.setTitle("Buy for " + presenter.price, for: .normal)
    }
    
    func updateView(withLoader isLoading: Bool) {
        chartsContainerView.configure(with: isLoading)
    }
    
    func updateView(withError message: String) {
        
    }
}
