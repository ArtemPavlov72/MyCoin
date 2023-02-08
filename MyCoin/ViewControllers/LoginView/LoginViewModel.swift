//
//  LoginViewModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func enterButtonPressed(with name: String?, and password: String?, completion: @escaping () -> Void)
    func coinTableViewModel() -> CoinTableViewModelProtocol
}

class LoginViewViewModel: LoginViewModelProtocol {
    
    func enterButtonPressed(with name: String?, and password: String?, completion: @escaping () -> Void) {
        guard let inputNameText = name, !inputNameText.isEmpty else { return }
        let nameTrimmingText = inputNameText.trimmingCharacters(in: .whitespaces)
        guard nameTrimmingText == DataManager.shared.getfakeUserName() else { return }
       
        guard let inputPasswordText = password, !inputPasswordText.isEmpty else { return }
        guard inputPasswordText == DataManager.shared.getFakeUserPassword() else { return }
       
        completion()
        
        let user = User(
            name: nameTrimmingText,
            password: inputPasswordText,
            isRegistered: true
        )
        UserManager.shared.save(user: user)
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    func coinTableViewModel() -> CoinTableViewModelProtocol {
        CoinTableViewModel()
    }
}
