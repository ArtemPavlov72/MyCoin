//
//  ViewController.swift
//  MyCoin
//
//  Created by Artem Pavlov on 09.01.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Private Properties
    var viewModel: LoginViewModelProtocol!

    //MARK: - Private Properties
    private lazy var nameTextField: UITextField = {
        let name = UITextField()
        name.borderStyle = .roundedRect
        name.returnKeyType = .next
        name.placeholder = "Enter your name"
        return name
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.borderStyle = .roundedRect
        password.returnKeyType = .done
        password.isSecureTextEntry = true
        password.placeholder = "Enter password"
        return password
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemGray2
        button.setTitleColor(UIColor.systemGray6, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .highlighted)
        button.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.spacing = 14.0
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(enterButton)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        nameTextField.delegate = self
        setupSubViews(verticalStackView)
        setupConstraints()
    }

    //MARK: - Private Methods
    private func setupSubViews(_ subViews: UIView...) {
        subViews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.7)
        ])
    }
    
    //вынести лишнюю логику в модель
    //добавить алерт при проверке имени и пароля
    @objc private func enterButtonTapped() {
        guard let inputNameText = nameTextField.text, !inputNameText.isEmpty else {return}
        let nameTrimmingText = inputNameText.trimmingCharacters(in: .whitespaces)
        guard nameTrimmingText == DataManager.shared.fakeUser.name else {return}
        
        guard let inputPasswordText = passwordTextField.text, !inputPasswordText.isEmpty else {return}
        guard inputPasswordText == DataManager.shared.fakeUser.password else {return}
        
        viewModel.enterButtonPressed(with: nameTrimmingText, and: inputPasswordText)
                
        let coinVC = CoinTableViewController()
        coinVC.navigationItem.hidesBackButton = true
        show(coinVC, sender: nil)
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            enterButtonTapped()
        }
        return true
    }
}



