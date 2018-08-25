//
//  TodoService.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

enum TodoService {

	case all(token: String)
	case get(id: Int, token: String)
	case search(title: String, token: String)
	case create(title: String, token: String)
	case update(Todo, token: String)
	case delete(Todo, token: String)

}

// MARK: - TargetType
extension TodoService: TargetType {
	var baseURL: URL {
		return API.baseUrl.appendingPathComponent("todos")
	}

	var path: String {
		switch self {
		case .all:
			return ""
		case .get(let id, _):
			return "\(id)"
		case .create:
			return ""
		case .search:
			return "search"
		case .update(let todo, _),
			 .delete(let todo, _):
			return "\(todo.id)"
		}
	}

	var method: Moya.Method {
		switch self {
		case .all,
			 .get,
			 .search:
			return .get
		case .create:
			return .post
		case .update:
			return .put
		case .delete:
			return .delete
		}
	}

	var task: Task {
		switch self {
		case .all,
			 .get:
			return .requestPlain
		case .search(let title, _):
			return .requestParameters(parameters: ["title": title], encoding: URLEncoding.queryString)
		case .create(let title, _):
			return .requestParameters(parameters: ["title": title], encoding: JSONEncoding.default)
		case .update(let todo, _):
			return .requestJSONEncodable(todo)
		case .delete:
			return .requestPlain
		}
	}

	var headers: [String: String]? {
		switch self {
		case .all(let token),
			 .get(_, let token),
			 .search(_, let token),
			 .create(_, let token),
			 .update(_, let token),
			 .delete(_, let token):
			return API.bearerHeaders(token: token)
		}
	}

	var sampleData: Data {
		return "".utf8Encoded
	}

}
