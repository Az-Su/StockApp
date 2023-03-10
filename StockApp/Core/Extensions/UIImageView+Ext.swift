//
//  UIImageView+Ext.swift
//  StockApp
//
//  Created by Sailau Almaz Maratuly on 08.03.2023.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImage(from source: String?, placeHolder: UIImage?) {
        guard let urlString = source, let url = URL(string: urlString) else { return }
        
        kf.setImage(with: .network(url), placeholder: placeHolder)
    }
}

