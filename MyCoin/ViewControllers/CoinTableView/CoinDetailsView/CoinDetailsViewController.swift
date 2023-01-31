//
//  CoinDetailsViewController.swift
//  MyCoin
//
//  Created by Артем Павлов on 29.01.2023.
//

import UIKit

class CoinDetailsViewController: UIViewController {
    
    //MARK: - Public Properties
    var coin: Coin?
    
    //MARK: - Private Properties
    private lazy var coinSymbolLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 14)
        text.text = coin?.data.symbol
        return text
    }()
    
    private lazy var coinNameLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        text.text = coin?.data.name
        return text
    }()
    
    private lazy var coinPriceLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        text.textColor = .systemCyan
        text.text = String(format: "%.6f", coin?.data.market_data.price_usd ?? 0) + " $"
        return text
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        text.textColor = .systemCyan
        text.textAlignment = .center
        text.text = "About"
        return text
    }()
    
    private lazy var rankLabel: UILabel = {
        let text = UILabel()
        text.text = "Rank"
        return text
    }()
    
    private lazy var coinRankInfoLabel: UILabel = {
        let text = UILabel()
        text.text = coin?.data.marketcap.rank.description
        return text
    }()
    
    private lazy var marketCapLabel: UILabel = {
        let text = UILabel()
        text.text = "Current marketcap"
        return text
    }()
    
    private lazy var marketCapInfoLabel: UILabel = {
        let text = UILabel()
        text.text = coin?.data.marketcap.current_marketcap_usd.description
        return text
    }()
    
    private lazy var change1hLabel: UILabel = {
        let text = UILabel()
        text.text = "Changes in 1 hour"
        return text
    }()
    
    private lazy var coinChange1hLabel: UILabel = {
        let text = UILabel()
        text.text = coin?.data.market_data.percent_change_usd_last_1_hour.description
        return text
    }()
    
    private lazy var change24hLabel: UILabel = {
        let text = UILabel()
        text.text = "Changes in 24 hours"
        return text
    }()
    
    private lazy var coinChange24hLabel: UILabel = {
        let text = UILabel()
        text.text = coin?.data.market_data.percent_change_usd_last_24_hours.description
        return text
    }()
    
    //MARK: - Stack Properties
    private lazy var rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 10.0
        stackView.addArrangedSubview(rankLabel)
        stackView.addArrangedSubview(coinRankInfoLabel)
        return stackView
    }()
    
    private lazy var marketCapStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 10.0
        stackView.addArrangedSubview(marketCapLabel)
        stackView.addArrangedSubview(marketCapInfoLabel)
        return stackView
    }()
    
    private lazy var change1hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 10.0
        stackView.addArrangedSubview(change1hLabel)
        stackView.addArrangedSubview(coinChange1hLabel)
        return stackView
    }()
    
    private lazy var change24hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 10.0
        stackView.addArrangedSubview(change24hLabel)
        stackView.addArrangedSubview(coinChange24hLabel)
        return stackView
    }()
    
    private lazy var mainInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 10.0
        stackView.addArrangedSubview(coinSymbolLabel)
        stackView.addArrangedSubview(coinNameLabel)
        stackView.addArrangedSubview(coinPriceLabel)
        return stackView
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .fill
        stackView.spacing = 12.0
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(rankStackView)
        stackView.addArrangedSubview(marketCapStackView)
        stackView.addArrangedSubview(change1hStackView)
        stackView.addArrangedSubview(change24hStackView)
        return stackView
    }()
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSubViews(mainInfoStackView, descriptionStackView)
        setupConstraints()
    }
    
    //MARK: - Private Methods
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subview in
            view.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        mainInfoStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.12).isActive = true
        mainInfoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainInfoStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
        
        descriptionStackView.topAnchor.constraint(equalTo: mainInfoStackView.bottomAnchor, constant: 40).isActive = true
        descriptionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
    }
}
