//
//  TodoTableViewCell.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class TodoTableViewCell: TableViewCell {

	static let reuseIdentifier = "todoCell"

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 24, weight: .semibold)
		label.textColor = Color.black
		label.backgroundColor = Color.white
		return label
	}()

	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12, weight: .regular)
		label.textColor = Color.skyBlue
		label.backgroundColor = Color.white
		return label
	}()

	private lazy var stackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
		view.axis = .vertical
		view.distribution = .fill
		view.alignment = .fill
		view.spacing = 5
		return view
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(stackView)
	}

	override func setupLayout() {
		stackView.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(20)
		}
	}

}

extension TodoTableViewCell {

	func configure(for todo: Todo) {
		let attributeString = NSMutableAttributedString(string: todo.title)

		if todo.isDone {
			// swiftlint:disable:next legacy_constructor
			attributeString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, attributeString.length))
		}

		titleLabel.attributedText = attributeString
		dateLabel.text = todo.dateCreated.dateTimeString()
	}

}
