//
//  AuthService.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

enum AuthService {

	case login(email: String, password: String)
	case register(user: User)

}

// MARK: - TargetType
extension AuthService: TargetType {
	var baseURL: URL {
		return API.baseUrl.appendingPathComponent("auth")
	}

	var path: String {
		switch self {
		case .login:
			return "login"
		case .register:
			return "register"
		}
	}

	var method: Moya.Method {
		switch self {
		case .login,
			 .register:
			return .post
		}
	}

	var task: Task {
		switch self {
		case .login:
			return .requestPlain
		case .register(let user):
			return .requestJSONEncodable(user)
		}

	}

	var headers: [String: String]? {
		switch self {
		case .login(let email, let password):
			return API.basicHeaders(email: email, password: password)
		case .register:
			return API.baseHeaders
		}
	}

	var sampleData: Data {
		return "".utf8Encoded
	}

}
