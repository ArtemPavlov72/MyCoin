//
//  CoinTableViewController.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import UIKit

class CoinTableViewController: UITableViewController {
    
    private let cellID = "cell"
   // private var coin: Coin?
    private var coins: [Coin] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemBrown

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
       // loadCoin()
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
    
//    private func loadCoin() {
//       // let url = DataManager.shared.getURL().first
//        NetworkManager.shared.fetchData(from: "https://data.messari.io/api/v1/assets/btc/metrics") { result in
//            switch result {
//            case.success(let coin):
//                self.coins.append(coin)
//                self.tableView.reloadData()
//            case.failure(let error):
//                print(error)
//            }
//        }
//    }
    
    private func loadCoins() {
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
            self.tableView.reloadData()
            print("All requests completed")
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let coin = coins[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = coin.data.name
        content.secondaryText = coin.data.market_data.price_usd.description
        cell.contentConfiguration = content
        return cell
    }
}
