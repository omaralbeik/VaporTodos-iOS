//
//  TodoView.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class TodoView: View {

	lazy var textView: UITextView = {
		let view = UITextView()
		view.font = .systemFont(ofSize: 18, weight: .regular)
		view.backgroundColor = Color.white
		view.textColor = Color.black
		view.tintColor = Color.skyBlue
		return view
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(textView)
	}

	override func setupLayout() {
		textView.snp.makeConstraints { make in
			if #available(iOS 11.0, *) {
				make.top.equalTo(safeAreaLayoutGuide).inset(10)
			} else {
				make.top.equalToSuperview().inset(60)
			}
			make.leading.trailing.bottom.equalToSuperview().inset(20)
		}
	}

}

// MARK: - Loadingable
extension TodoView: Loadingable {}
