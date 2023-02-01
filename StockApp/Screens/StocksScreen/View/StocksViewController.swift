//
//  StocksViewController.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 10.01.2023.
//

import UIKit

final class StocksViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        return tableView
    }()
    
    private var stocks: [Stock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        setupConstraints()
        
        getStocks()
    }
    
    private func getStocks() {
        let client = Network()
        let service: StocksServiceProtocol = StocksService(client: client)
        
        service.getStocks { [weak self] result in
            switch result {
            case .success(let stocks):
                self?.stocks = stocks
                self?.tableView.reloadData()
            case .failure(_):
                print("Error")
            }
        }
    }
}

//MARK: - TableViewDataSource and UITableViewDelegate

extension StocksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.setBackgroundColor(for: indexPath.row)
        cell.configure(with: stocks[indexPath.row])
        return cell
    }
}

//MARK: - Setup views and constraints methods

extension StocksViewController {
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
