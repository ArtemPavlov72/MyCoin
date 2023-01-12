//
//  CoinTableViewController.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import UIKit

class CoinTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemBrown
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close, //поменять стиль кнопки логаута
            target: self,
            action: #selector(logOut)
        )
    }
    
    @objc private func logOut() {
        UserManager.shared.deleteUserData()
        AppDelegate.shared.rootViewController.switchToLogout()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }

}
