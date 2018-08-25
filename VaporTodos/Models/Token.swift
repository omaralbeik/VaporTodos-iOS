//
//  Token.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

struct Token: Codable {

	var expiresAt: Date
	var token: String
	var userId: String

}
