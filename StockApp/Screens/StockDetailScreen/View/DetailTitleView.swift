//
//  DetailTitleView.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 26.02.2023.
//

import UIKit

final class DetailTitleView: UIView {
    struct TitleModel {
        let symbol: String
        let name: String
        
        static func from(stockModel model: StockModelProtocol) -> TitleModel {
            TitleModel(symbol: model.symbol, name: model.name)
        }
    }
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .semiBold(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TitleModel) {
        symbolLabel.text = model.symbol.uppercased()
        nameLabel.text = model.name
    }
}

//MARK: - Setup views and constraints methods

private extension DetailTitleView {
    private func setupViews() {
        addSubview(symbolLabel)
        addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            symbolLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            symbolLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            symbolLabel.topAnchor.constraint(equalTo: topAnchor),
            
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
