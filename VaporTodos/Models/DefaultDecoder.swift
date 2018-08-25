//
//  DefaultDecoder.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class DefaultDecoder: JSONDecoder {

	override init() {
		super.init()

		if #available(iOS 10.0, *) {
			dateDecodingStrategy = .iso8601
		} else {
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
			dateDecodingStrategy = .formatted(formatter)
		}
	}

}
