//
//  AuthMode.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/24/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

enum AuthMode {

	case login
	case register

}

extension AuthMode {

	init?(index: Int) {
		switch index {
		case 0:
			self = .register
		case 1:
			self = .login
		default:
			return nil
		}
	}

	var title: String {
		switch self {
		case .login:
			return "Login"
		case .register:
			return "Register"
		}
	}

}
