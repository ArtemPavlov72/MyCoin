//
//  CoinTableViewController.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import UIKit

class CoinTableViewController: UITableViewController {
    
    private var coins: [Coin] = []
    private var spinnerView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemBrown
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseId)
        setupNavigationBar()
        loadCoins()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close, //поменять стиль кнопки логаута
            target: self,
            action: #selector(logOut)
        )
    }
    
    
    private func loadCoins() {
        if let navigationController = navigationController {
            spinnerView = showSpinner(in: navigationController.view)
        }
        
        let urls = DataManager.shared.getURL()
        let group = DispatchGroup()
        
        _ = urls.map { url in
            group.enter()
            
            NetworkManager.shared.fetchData(from: url) { result in
                switch result {
                case.success(let coin):
                    self.coins.append(coin)
                    group.leave()
                case.failure(let error):
                    print(error)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.spinnerView?.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        
        activityIndicator.style = .large
        activityIndicator.startAnimating()
   
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    @objc private func logOut() {
        UserManager.shared.deleteUserData()
        AppDelegate.shared.rootViewController.switchToLogout()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseId, for: indexPath) as? CoinTableViewCell else { return  CoinTableViewCell() }
        let coin = coins[indexPath.row]
        cell.configure(with: coin)
        
//        var content = cell.defaultContentConfiguration()
//        content.text = coin.data.name
//        content.secondaryText = coin.data.market_data.price_usd.description
//        cell.contentConfiguration = content
        return cell
    }
}
