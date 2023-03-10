//
//  SearchViewController.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 08.03.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    private let presenter: SearchStocksPresenterProtocol
    
    init(presenter: SearchStocksPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var searchView: SearchView = {
        let view = SearchView()
        view.delegate = presenter
        view.translatesAutoresizingMaskIntoConstraints = false
        view.searchTextField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        view.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(RequestSearch.self, forCellWithReuseIdentifier: RequestSearch.typeName)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    private lazy var searchesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You’ve searched for this"
        label.font = .bold(size: 18)
        return label
    }()
    
    private lazy var clearSearchesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .bold(size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearSearchesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        presenter.loadView()
    }
    
    private func showError(_ message: String) {
        // show error
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else { return UITableViewCell() }
        cell.setBackgroundColor(for: indexPath.row)
        cell.configure(with: presenter.model(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentModel = presenter.model(for: indexPath)
        let detailStockVC = Assembly.assembler.detailVC(for: currentModel)
        navigationController?.pushViewController(detailStockVC, animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.savedSearches = UserDefaults.standard.array(forKey: "savedSearches") as? [String] ?? []
        
        return presenter.savedSearches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestSearch", for: indexPath) as! RequestSearch
        
        cell.textLabel.text = presenter.savedSearches[indexPath.row]
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RequestSearch else { return }
        
        searchView.searchTextField.text = cell.textLabel.text
        
        editingBegan(searchView.searchTextField)
    }
}

extension SearchViewController: StocksViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        // show or hide loader
    }
    
    func updateView(withError message: String) {
        // show error message
    }
    
    func updateCell(for indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

//MARK: - Setup views and constraints methods

private extension SearchViewController {
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(searchView)
        view.addSubview(tableView)
        
        view.addSubview(searchesStackView)
        searchesStackView.addArrangedSubview(collectionLabel)
        searchesStackView.addArrangedSubview(clearSearchesButton)
        
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            searchesStackView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 39),
            searchesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            collectionView.topAnchor.constraint(equalTo: searchesStackView.bottomAnchor,constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func saveSearchText() {
        guard let searchTerm = searchView.searchTextField.text, !searchTerm.isEmpty else { return }
        
        if let value = UserDefaults.standard.object(forKey: "savedSearches") as? String {
            if value == searchTerm {
                // Data in UserDefaults matches the variable
                print("Data in UserDefaults matches the variable")
            } else {
                // Data in UserDefaults does not match the variable
                print("Data in UserDefaults does not match the variable")
            }
        } else {
            // Data not found in UserDefaults
            print("Data not found in UserDefaults")
        }
        
        presenter.savedSearches.append(searchTerm)
        
        UserDefaults.standard.set(presenter.savedSearches, forKey: "savedSearches")
        collectionView.reloadData()
    }
}

//MARK: - Button Actions

private extension SearchViewController {
    @objc private func backButtonTapped() {
        self.searchView.infoStackView.isHidden = true
        self.tableView.isHidden = true
        self.searchView.backButton.isHidden = true
        self.searchView.clearButton.isHidden = true
        
        self.collectionView.isHidden = false
        self.collectionLabel.isHidden = false
        self.searchView.searchButton.isHidden = false
        self.searchesStackView.isHidden = false
        
        saveSearchText()
        self.view.endEditing(true)
    }
    
    @objc func editingBegan(_ textField: UITextField) {
        collectionView.isHidden = true
        collectionLabel.isHidden = true
        clearSearchesButton.isHidden = true
        
        tableView.isHidden = false
    }
    
    @objc func clearSearchesButtonTapped() {
        UserDefaults.standard.removeObject(forKey: "savedSearches")
        presenter.savedSearches.removeAll()
        collectionView.reloadData()
    }
}
