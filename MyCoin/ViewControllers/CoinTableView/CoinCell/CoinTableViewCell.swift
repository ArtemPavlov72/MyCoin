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
    private let coinNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let coinPriceLabel = UILabel()
    private let coinChangeLabel = UILabel()
    
    private lazy var coinDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .trailing
        stackView.spacing = 10.0
        stackView.addArrangedSubview(coinPriceLabel)
        stackView.addArrangedSubview(coinChangeLabel)
        return stackView
    }()
    
    var viewModel: CoinCellViewModelProtocol? {
        didSet {
            coinNameLabel.text = viewModel?.coinName
            coinPriceLabel.text = viewModel?.coinPrice
            coinChangeLabel.text = viewModel?.coinChange
            guard let isChangeGrow = viewModel?.isChangeGrow else { return }
            coinChangeLabel.textColor = isChangeGrow ? .systemGreen : .systemRed
        }
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews(coinNameLabel, coinDataStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subview in
            addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        coinNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coinNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        
        coinDataStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        coinDataStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
}
