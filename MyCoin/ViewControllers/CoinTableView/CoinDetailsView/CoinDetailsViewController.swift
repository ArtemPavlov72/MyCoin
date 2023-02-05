//
//  CoinDetailsViewController.swift
//  MyCoin
//
//  Created by Artem Pavlov on 29.01.2023.
//

import UIKit

class CoinDetailsViewController: UIViewController {
    
    //MARK: - Public Properties
    var viewModel: CoinDetailsViewModelProtocol!
    
    //MARK: - Private Properties
    private var coinSymbolLabel = UILabel()
    private var coinNameLabel = UILabel()
    private var coinPriceLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var rankLabel = UILabel()
    private var coinRankInfoLabel = UILabel()
    private var marketCapLabel = UILabel()
    private var marketCapInfoLabel = UILabel()
    private var change1hLabel = UILabel()
    private var coinChange1hInfoLabel = UILabel()
    private var change24hLabel = UILabel()
    private var coinChange24hInfoLabel = UILabel()
    
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
        stackView.addArrangedSubview(coinChange1hInfoLabel)
        return stackView
    }()
    
    private lazy var change24hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.spacing = 10.0
        stackView.addArrangedSubview(change24hLabel)
        stackView.addArrangedSubview(coinChange24hInfoLabel)
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
        setupUI()
        setupSubViews(mainInfoStackView, descriptionStackView)
        setupConstraints()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        coinSymbolLabel.text = viewModel.coinSymbol
        coinSymbolLabel.font = UIFont.systemFont(ofSize: 14)
        
        coinNameLabel.text = viewModel.coinName
        coinNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        
        coinPriceLabel.text = viewModel.coinPrice
        coinPriceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        coinPriceLabel.textColor = .systemCyan
        
        descriptionLabel.text = viewModel.description
        descriptionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        descriptionLabel.textAlignment = .left
        
        rankLabel.text = viewModel.rank
        coinRankInfoLabel.text = viewModel.coinRankInfo
        
        marketCapLabel.text = viewModel.marketCap
        marketCapInfoLabel.text = viewModel.marketCapInfo
        
        change1hLabel.text = viewModel.coinChange1h
        coinChange1hInfoLabel.text = viewModel.coinChange1hInfo
        
        change24hLabel.text = viewModel.coinChange24h
        coinChange24hInfoLabel.text = viewModel.coinChange24hInfo
    }
    
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
