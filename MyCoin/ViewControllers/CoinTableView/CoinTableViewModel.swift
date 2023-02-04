//
//  CoinTableViewModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 11.01.2023.
//

import Foundation

protocol CoinTableViewModelProtocol {
    func fetchCoins(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CoinCellViewModelProtocol
}

class CoinTableViewModel: CoinTableViewModelProtocol {
    
    private var coins: [Coin] = []
    
    func fetchCoins(completion: @escaping () -> Void) {
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
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        coins.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CoinCellViewModelProtocol {
        let coin = coins[indexPath.row]
        return CoinTableViewCellModel(coin: coin)
    }
}
