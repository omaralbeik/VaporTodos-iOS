//
//  AuthView.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/24/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class AuthView: View {

	lazy var modeSegmentedControl: UISegmentedControl = {
		let control = UISegmentedControl(items: [AuthMode.register.title, AuthMode.login.title])
		control.selectedSegmentIndex = 0
		control.backgroundColor = Color.white
		control.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)], for: .normal)
		control.tintColor = Color.skyBlue
		return control
	}()

	lazy var emailTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Email Address"
		textField.keyboardType = .emailAddress
		textField.autocorrectionType = .no
		textField.autocapitalizationType = .none
		if #available(iOS 10.0, *) {
			textField.textContentType = .emailAddress
		}
		setTextFieldStyle(textField)
		return textField
	}()

	lazy var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Password"
		textField.isSecureTextEntry = true
		if #available(iOS 11.0, *) {
			textField.textContentType = .password
		}
		setTextFieldStyle(textField)
		return textField
	}()

	lazy var nameTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Name (Optional)"
		if #available(iOS 11.0, *) {
			textField.textContentType = .name
		}
		setTextFieldStyle(textField)
		return textField
	}()

	lazy var submitButton: UIButton = {
		let button = UIButton(type: .system)
		button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
		button.setTitle(AuthMode.register.title, for: .normal)
		button.backgroundColor = Color.skyBlue
		button.tintColor = Color.white
		button.layer.cornerRadius = 4
		return button
	}()

	private lazy var stackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [emailTextField, nameTextField, passwordTextField])
		view.axis = .vertical
		view.alignment = .fill
		view.distribution = .fillEqually
		view.spacing = 8
		return view
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(modeSegmentedControl)
		addSubview(stackView)
		addSubview(submitButton)
	}

	override func setupLayout() {
		modeSegmentedControl.snp.makeConstraints { make in
			if #available(iOS 11.0, *) {
				make.top.equalTo(safeAreaLayoutGuide).offset(30)
			} else {
				make.top.equalToSuperview().inset(50)
			}
			make.leading.trailing.equalToSuperview().inset(20)
			make.height.equalTo(45)
		}

		emailTextField.snp.makeConstraints { make in
			make.height.equalTo(45)
		}

		stackView.snp.makeConstraints { make in
			make.top.equalTo(modeSegmentedControl.snp.bottom).offset(20)
			make.leading.trailing.equalToSuperview().inset(20)
		}

		submitButton.snp.makeConstraints { make in
			make.top.equalTo(stackView.snp.bottom).offset(20)
			make.leading.trailing.equalTo(stackView)
			make.height.equalTo(45)
		}
	}

}

// MARK: - Helpers
extension AuthView {

	func configure(for mode: AuthMode) {
		submitButton.setTitle(mode.title, for: .normal)

		switch mode {
		case .login:
			nameTextField.removeFromSuperview()

		case .register:
			stackView.insertArrangedSubview(nameTextField, at: 1)
		}
	}

	func setTextFieldStyle(_ textField: UITextField) {
		textField.backgroundColor = Color.darkGray.withAlphaComponent(0.1)
		textField.textColor = Color.black
		textField.tintColor = Color.skyBlue
		textField.layer.cornerRadius = 4
		textField.textAlignment = .center
	}

}
