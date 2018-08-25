//
//  AuthViewController.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/24/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class AuthViewController: ViewController, Layouting {
	typealias ViewType = AuthView

	var mode: AuthMode = .register {
		didSet {
			layoutableView.configure(for: mode)
		}
	}

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutableView.modeSegmentedControl.addTarget(self, action: #selector(didChangeModeSegmentedControlIndex(_:)), for: .valueChanged)
		layoutableView.submitButton.addTarget(self, action: #selector(didTapSubmitButton(_:)), for: .touchUpInside)

	}

}

// MARK: - Actions
private extension AuthViewController {

	@objc
	func didChangeModeSegmentedControlIndex(_ control: UISegmentedControl) {
		mode = AuthMode(index: control.selectedSegmentIndex)!
	}

	@objc
	func didTapSubmitButton(_ button: UIButton) {
		guard let email = layoutableView.emailTextField.text?.trimmed else {
			return
		}

		guard let password = layoutableView.passwordTextField.text?.trimmed else {
			return
		}

		let name = layoutableView.nameTextField.text?.trimmed

		switch mode {
		case .register:
			register(sender: layoutableView, email: email, name: name, password: password)
		case .login:
			login(sender: layoutableView, email: email, password: password)
		}
	}

}

// MARK: - Networking
private extension AuthViewController {

	func register(sender: Loadingable? = nil, email: String, name: String?, password: String) {
		let user = User(email: email, name: name, password: password)

		sender?.setLoading(true)
		API.authProvider.request(.register(user: user), dataType: User.self) { result in
			sender?.setLoading(false)
			switch result {
			case .failure(let error):
				Alert(error: error).show()
			case .success:
				self.login(sender: sender, email: email, password: password)
			}
		}
	}

	func login(sender: Loadingable? = nil, email: String, password: String) {
		sender?.setLoading(true)
		API.authProvider.request(.login(email: email, password: password), dataType: Token.self) { result in
			sender?.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(error: error).show()
			case .success(let token):
				AuthCache.token = token
				(UIApplication.shared.delegate as! AppDelegate).showTodosViewController()
			}
		}
	}

}
