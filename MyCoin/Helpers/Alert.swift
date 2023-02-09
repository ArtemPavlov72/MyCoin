//
//  Alert.swift
//  MyCoin
//
//  Created by Artem Pavlov on 08.02.2023.
//

import UIKit

protocol AlertViewModelProtocol {
    init(title: String, massage: String)
    func showAlert(in vc: UIViewController) -> Void
}

class AlertController: AlertViewModelProtocol {
    
    private let titleMassage: String
    private let massage: String
    
    func showAlert(in vc: UIViewController) -> Void {
        let alert = UIAlertController(title: titleMassage, message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        return vc.present(alert, animated: true)
    }
    
    required init(title: String, massage: String) {
        self.titleMassage = title
        self.massage = massage
    }
}

enum AlertError: Error {
    case noName
    case wrongName
    case noPassword
    case wrongPassword
}
