//
//  API.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

struct API {

	static let authProvider = MoyaProvider<AuthService>()
	static let todoProvider = MoyaProvider<TodoService>()

	static var baseUrl: URL {
		//TODO: - Replace this with your server address
		return URL(string: "http://104.248.21.78/api")!
	}

	static var baseHeaders: [String: String] {
		return ["Content-type": "application/json"]
	}

	static func basicHeaders(email: String, password: String) -> [String: String] {
		var headers = baseHeaders
		let basic = "\(email):\(password)"
		headers["Authorization"] = "Basic \(basic.base64String)"
		return headers
	}

	static func bearerHeaders(token: String) -> [String: String] {
		var headers = baseHeaders
		headers["Authorization"] = "Bearer \(token)"
		return headers
	}

}

extension String {

	var urlEscaped: String {
		return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
	}

	var utf8Encoded: Data {
		return data(using: .utf8)!
	}

}
