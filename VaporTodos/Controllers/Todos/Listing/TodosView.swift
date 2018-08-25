//
//  TodosView.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/24/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class TodosView: View {

	lazy var tableView: UITableView = {
		let view = UITableView()
		view.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.reuseIdentifier)

		view.estimatedRowHeight = 100
		view.rowHeight = UITableViewAutomaticDimension

		view.backgroundColor = Color.white
		return view
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(tableView)
	}

	override func setupLayout() {
		tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
	}

}
