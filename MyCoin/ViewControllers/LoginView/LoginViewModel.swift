//
//  LoginViewModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func enterButtonPressed(with name: String, and password: String)
    func coinTableViewModel() -> CoinTableViewModelProtocol
}

class LoginViewViewModel: LoginViewModelProtocol {

    //проверка по ключу регистрации добавить
    func enterButtonPressed(with name: String, and password: String) {
        let user = User(
            name: name,
            password: password,
            isRegistered: true
        )
        UserManager.shared.save(user: user)
    }
    
    func coinTableViewModel() -> CoinTableViewModelProtocol {
        CoinTableViewModel()
    }
}
