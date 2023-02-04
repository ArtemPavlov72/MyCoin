//
//  LoginViewModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func enterButtonPressed(with name: String, and password: String, completion: @escaping () -> Void)
    func coinTableViewModel() -> CoinTableViewModelProtocol
}

class LoginViewViewModel: LoginViewModelProtocol {
    
    func enterButtonPressed(with name: String, and password: String, completion: @escaping () -> Void) {
        let nameTrimmingText = name.trimmingCharacters(in: .whitespaces)
        guard nameTrimmingText == DataManager.shared.fakeUser.name else { return }
        guard password == DataManager.shared.fakeUser.password else { return }
        completion()
        
        let user = User(
            name: name,
            password: password,
            isRegistered: true
        )
        UserManager.shared.save(user: user)
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    func coinTableViewModel() -> CoinTableViewModelProtocol {
        CoinTableViewModel()
    }
}
