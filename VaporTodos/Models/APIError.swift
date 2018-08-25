//
//  APIError.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

public enum APIError: Error {
	case moya(MoyaError)
	case decoding(Error)
	case server(String?)
	case unknow
}

// MARK: - LocalizedError
extension APIError: LocalizedError {

	private var unknownErrorMessage: String {
		return L10n.Generic.unknownServerError
	}

	public var errorDescription: String? {
		switch self {
		case .moya(let error):
			return error.localizedDescription
		case .decoding(let error):
			return error.localizedDescription
		case .server(let message):
			return message
		case .unknow:
			return unknownErrorMessage
		}
	}

	public var localizedDescription: String {
		return errorDescription ?? unknownErrorMessage
	}

}
