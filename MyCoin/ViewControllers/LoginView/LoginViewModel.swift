//
//  LoginViewModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 10.01.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    func enterButtonPressed(with name: String?, and password: String?, completion: @escaping(Result<CoinTableViewModel, AlertError>) -> Void)
    func alertViewModel(with error: AlertError) -> AlertViewModelProtocol
}

class LoginViewViewModel: LoginViewModelProtocol {
    func alertViewModel(with error: AlertError) -> AlertViewModelProtocol {
        var title = ""
        var massage = ""
        
        switch error {
        case .noName:
            title = "Name is empty"
            massage = "Enter your name"
        case .wrongName:
            title =  "Name is wrong"
            massage = "Enter correct name"
        case .noPassword:
            title = "Password is empty"
            massage = "Enter password"
        case .wrongPassword:
            title = "Password is wrong"
            massage = "Enter correct password"
        }
        
        let alert = AlertController(title: title, massage: massage)
        return alert
    }
    
    func enterButtonPressed(with name: String?, and password: String?, completion: @escaping(Result<CoinTableViewModel, AlertError>) -> Void) {
        guard let inputNameText = name, !inputNameText.isEmpty else { return completion(.failure(.noName)) }
        let nameTrimmingText = inputNameText.trimmingCharacters(in: .whitespaces)
        guard nameTrimmingText == DataManager.shared.getfakeUserName() else { return completion(.failure(.wrongName)) }
        
        guard let inputPasswordText = password, !inputPasswordText.isEmpty else { return completion(.failure(.noPassword)) }
        guard inputPasswordText == DataManager.shared.getFakeUserPassword() else { return completion(.failure(.wrongPassword)) }
       
        completion(.success(CoinTableViewModel()))
        
        let user = User(
            name: nameTrimmingText,
            password: inputPasswordText,
            isRegistered: true
        )
        UserManager.shared.save(user: user)
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    private func coinTableViewModel() -> CoinTableViewModelProtocol {
        CoinTableViewModel()
    }
}
