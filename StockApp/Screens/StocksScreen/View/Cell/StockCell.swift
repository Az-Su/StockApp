//
//  StockCell.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 19.01.2023.
//

import UIKit
import Kingfisher

final class StockCell: UITableViewCell {
    private var favoriteAction: (() -> Void)?
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Path"), for: .normal)
        button.setImage(UIImage(named: "Path2"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.semiBold(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.semiBold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var procentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.backgroundGreen
        label.font = UIFont.semiBold(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var elementsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        favoriteAction = nil
    }
    
    func setBackgroundColor(for row: Int) {
        elementsView.backgroundColor = row % 2 == 0
        ? UIColor.backgroundGray
        : UIColor.white
    }
    
    func viewAnimate() {
        animate()
    }
    
    private func animate() {
        guard let previousBackgroundColor = elementsView.backgroundColor else { return }
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options:[.curveEaseOut], animations: {
            self.elementsView.backgroundColor = .selectionColor
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn]) {
                self.elementsView.backgroundColor = previousBackgroundColor
            }
        })
    }
    
    func configure(with model: StockModelProtocol){
        iconView.setImage(from: model.iconURL, placeHolder: UIImage(named: "YNDX"))
        symbolLabel.text = model.symbol.uppercased()
        companyLabel.text = model.name
        priceLabel.text = model.price
        procentLabel.text = model.change
        procentLabel.textColor = model.changeColor
        favoriteButton.isSelected = model.isFavorite
        favoriteAction = {
            model.setFavorite()
        }
    }
}

//MARK: - Setup views and constraints methods

private extension StockCell {
    private func setupViews() {
        selectionStyle = .none
        
        contentView.addSubview(elementsView)
        elementsView.addSubview(iconView)
        elementsView.addSubview(symbolLabel)
        elementsView.addSubview(companyLabel)
        elementsView.addSubview(priceLabel)
        elementsView.addSubview(procentLabel)
        elementsView.addSubview(favoriteButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: elementsView.leadingAnchor,constant: 8),
            iconView.topAnchor.constraint(equalTo: elementsView.topAnchor,constant: 8),
            iconView.bottomAnchor.constraint(equalTo: elementsView.bottomAnchor,constant: -8),
            iconView.heightAnchor.constraint(equalToConstant: 52),
            iconView.widthAnchor.constraint(equalToConstant: 52),
            
            
            symbolLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor,constant: 12),
            symbolLabel.topAnchor.constraint(equalTo: elementsView.topAnchor,constant: 14),
            
            companyLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor,constant: 12),
            companyLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: elementsView.trailingAnchor,constant: -17),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14),
            
            procentLabel.trailingAnchor.constraint(equalTo: elementsView.trailingAnchor,constant: -12),
            procentLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            
            favoriteButton.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor,constant: 6),
            favoriteButton.topAnchor.constraint(equalTo: elementsView.topAnchor,constant: 17),
            favoriteButton.heightAnchor.constraint(equalToConstant: 16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 16),
            
            elementsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            elementsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            elementsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            elementsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

//MARK: - Button actions

extension StockCell {
    @objc private func favoriteButtonTap() {
        favoriteButton.isSelected.toggle()
        favoriteAction?()
    }
}
