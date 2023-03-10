//
//  SearchRequest.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 08.03.2023.
//

import Foundation
import UIKit

final class RequestSearch: UICollectionViewCell {
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .semiBold(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
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
}

//MARK: - Setup views and constraints methods

extension RequestSearch {
    private func setupViews() {
        contentView.addSubview(textLabel)
        contentView.backgroundColor = .backgroundGray
        contentView.layer.cornerRadius = 20
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

