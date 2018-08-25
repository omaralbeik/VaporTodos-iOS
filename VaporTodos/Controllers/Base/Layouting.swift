//
//  Layouting.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/24/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

protocol Layouting: AnyObject {

	associatedtype ViewType: UIView
	var layoutableView: ViewType { get }

}

extension Layouting where Self: UIViewController {

	var layoutableView: ViewType {
		return view as! ViewType
	}

}
