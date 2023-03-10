//
//  SearchView.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 08.03.2023.
//

import UIKit

final class SearchView: UIStackView {
    weak var delegate: SearchTextFiledDelegate?
    
    public lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Find stocks"
        textField.font = UIFont.semiBold(size: 16)
        textField.tintColor = .black
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        textField.returnKeyType = .go
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        return textField
    }()
    
    public lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Ellipse"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    public lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clear"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private lazy var showMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show more", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.bold(size: 12)
        button.addTarget(self, action: #selector(showMoreButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var itemsView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Stocks"
        label.font = UIFont.bold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, showMoreButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.isHidden = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup views and constraints methods

extension SearchView {
    private func setupViews() {
        axis = .vertical
        spacing = 30
        alignment = .fill
        distribution = .fill
        
        itemsView.addSubview(searchButton)
        itemsView.addSubview(backButton)
        itemsView.addSubview(searchTextField)
        itemsView.addSubview(clearButton)
        
        addArrangedSubview(itemsView)
        addArrangedSubview(infoStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemsView.heightAnchor.constraint(equalToConstant: 45),
            
            searchButton.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor, constant: 16),
            searchButton.centerYAnchor.constraint(equalTo: itemsView.centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 16),
            searchButton.widthAnchor.constraint(equalToConstant: 16),
            
            backButton.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: itemsView.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 16),
            
            clearButton.trailingAnchor.constraint(equalTo: itemsView.trailingAnchor, constant: -16),
            clearButton.centerYAnchor.constraint(equalTo: itemsView.centerYAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 16),
            clearButton.widthAnchor.constraint(equalToConstant: 16),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: -10),
            searchTextField.centerYAnchor.constraint(equalTo: itemsView.centerYAnchor),
        ])
    }
}

//MARK: - Button Actions

extension SearchView {
    @objc func editingBegan(_ textField: UITextField) {
        backButton.isHidden = false
        clearButton.isHidden = false
        infoStackView.isHidden = false
        
        searchButton.isHidden = true
    }
    
    @objc private func clearButtonTapped() {
        searchTextField.text = ""
        textDidChange(sender: searchTextField)
    }
    
    @objc private func showMoreButtonTapped() {
        endEditing(true)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        delegate?.textDidChange(to: sender.text)
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


