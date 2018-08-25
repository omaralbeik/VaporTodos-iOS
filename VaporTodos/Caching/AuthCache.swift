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
			return UserDefaults.standard.object(Token.self, with: "token")
		}
		set {
			guard let newToken = newValue else {
				UserDefaults.standard.set(nil, forKey: "token")
				return
			}
			UserDefaults.standard.set(object: newToken, forKey: "token")
		}
	}

	static var isAuthenticated: Bool {
		guard let aToken = token else { return false }
		return aToken.expiresAt > Date()
	}

}
