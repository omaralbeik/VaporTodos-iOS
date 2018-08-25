//
//  Todo.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

struct Todo: Codable {

	var id: Int
	var title: String
	var isDone: Bool
	var dateCreated: Date

}
