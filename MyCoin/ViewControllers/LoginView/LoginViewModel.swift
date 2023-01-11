//
//  LoginViewModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func enterButtonPressed(with name: String, and password: String)
}

class LoginViewViewModel: LoginViewModelProtocol {
    
    //MARK: - Public Methods
    func enterButtonPressed(with name: String, and password: String) {
        let user = User(
            name: name,
            password: password,
            isRegistered: true
        )
        UserSettingManager.shared.save(user: user)
    }
    
}
