//
//  LoginViewModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func enterButtonPressed(with userName: String)
}

class LoginViewViewModel: LoginViewModelProtocol {
    
    //MARK: - Public Methods
    func enterButtonPressed(with userName: String) {
        let user = User(
            name: userName,
            isRegistered: true
        )
        UserSettingManager.shared.save(user: user)
    }
    
}
