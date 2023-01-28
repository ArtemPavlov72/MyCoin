//
//  CoinTableViewCell.swift
//  MyCoin
//
//  Created by Артем Павлов on 28.01.2023.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    
    //MARK: - Static Properties
    static let reuseId: String = "coinCell"
    
    //MARK: - Public Properties
    private let coinNameLabel = UILabel()
    private let coinPriceLabel = UILabel()
    private let coinChangeLabel = UILabel()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews(coinNameLabel, coinPriceLabel, coinChangeLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configure(with coin: Coin) {
        coinNameLabel.text = coin.data.name
        coinPriceLabel.text = String(format: "%.2f", coin.data.market_data.price_usd) + "$"
        coinChangeLabel.text = String(format: "%.2f", coin.data.market_data.percent_change_usd_last_24_hours) + "%"
    }
    
    //MARK: - Private Methods
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subview in
            self.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        coinNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coinNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        
        coinChangeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coinChangeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        coinPriceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coinPriceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
}
