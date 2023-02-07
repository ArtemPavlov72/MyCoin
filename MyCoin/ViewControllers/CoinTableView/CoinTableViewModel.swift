//
//  CoinTableViewModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 11.01.2023.
//

import Foundation

protocol CoinTableViewModelProtocol {
    var viewModelDidChange: ((CoinTableViewModelProtocol) -> Void)? { get set }
    var filterButtonStatus: Bool { get }
    func fetchCoins(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> CoinCellViewModelProtocol
    func logoutButtonPressed()
    func filterButtonPressed()
    func coinDetailsViewModel(at indexPath: IndexPath) -> CoinDetailsViewModelProtocol
}

class CoinTableViewModel: CoinTableViewModelProtocol {
    //MARK: - Public Properties
    var viewModelDidChange: ((CoinTableViewModelProtocol) -> Void)?
    
    var filterButtonStatus: Bool {
        get {
            UserManager.shared.getFilterStatus()
        } set {
            UserManager.shared.setFilterStatus(with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    //MARK: - Private Properties
    private var coins: [Coin] = []
    
    //MARK: - Public Methods
    func fetchCoins(completion: @escaping () -> Void) {
        let urls = DataManager.shared.getURLs()
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
        let coin = getSortedCoins(from: coins)[indexPath.row]
        return CoinTableViewCellModel(coin: coin)
    }
    
    func logoutButtonPressed() {
        UserManager.shared.deleteUserData()
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
    func filterButtonPressed() {
        filterButtonStatus.toggle()
    }
    
    func coinDetailsViewModel(at indexPath: IndexPath) -> CoinDetailsViewModelProtocol {
        let coin = getSortedCoins(from: coins)[indexPath.row]
        return CoinDetailsViewModel(coin: coin)
    }
    
    //MARK: - Private Methods
    private func getSortedCoins(from coins: [Coin]) -> [Coin] {
        let sortedCoins = filterButtonStatus
        ? coins.sorted {
            $0.data.market_data.percent_change_usd_last_1_hour
            > $1.data.market_data.percent_change_usd_last_1_hour
        }
        : coins.sorted {
            $0.data.market_data.percent_change_usd_last_1_hour
            < $1.data.market_data.percent_change_usd_last_1_hour
        }
        return sortedCoins
    }
}
