//
//  CoinTableViewController.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import UIKit

class CoinTableViewController: UITableViewController {
    
    //MARK: - Public Properties
    var viewModel: CoinTableViewModelProtocol! {
        didSet {
            viewModel.fetchCoins {
                self.spinnerView?.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Private Properties
    private var spinnerView: UIActivityIndicatorView?
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        guard let navigationController = navigationController else { return }
        spinnerView = showSpinner(in: navigationController.view)
    }
    
    //MARK: - Private Methods
    private func setupTableView() {
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = 70
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseId)
    }
    
    private func setupNavigationBar() {
        title = "MyCoin"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logOut)
        )
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
        viewModel.logoutButtonPressed()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseId, for: indexPath) as? CoinTableViewCell else { return  CoinTableViewCell() }
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coinDetailsViewModel = viewModel.coinDetailsViewModel(at: indexPath)
        let coinDetailsViewController = CoinDetailsViewController()
        coinDetailsViewController.viewModel = coinDetailsViewModel
        show(coinDetailsViewController, sender: nil)
    }
}
