//
//  AuthCache.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

final class AuthCache {

	static var token: Token? {
		get {
			return UserDefaults.standard.object(Token.self, with: Keys.token.rawValue)
		}
		set {
			guard let newToken = newValue else {
				UserDefaults.standard.set(nil, forKey: Keys.token.rawValue)
				return
			}
			UserDefaults.standard.set(object: newToken, forKey: Keys.token.rawValue)
		}
	}

	static var isAuthenticated: Bool {
		guard let aToken = token else { return false }
		return aToken.expiresAt > Date()
	}

}

extension AuthCache {

	enum Keys: String {
		case token
	}

}
