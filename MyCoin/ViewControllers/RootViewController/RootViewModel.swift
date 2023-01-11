//
//  RootViewModel.swift
//  MyCoin
//
//  Created by Artem Pavlov on 11.01.2023.
//

import Foundation

protocol RootViewModelDelegate {
    func loginViewModel() -> LoginViewModelProtocol
}

class RootViewModel: RootViewModelDelegate {
    func loginViewModel() -> LoginViewModelProtocol {
        LoginViewViewModel()
    }
}
