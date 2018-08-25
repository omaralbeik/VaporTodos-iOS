//
//  TodoViewController.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class TodoViewController: ViewController, Layouting {
	typealias ViewType = TodoView

	var todo: Todo?

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutableView.textView.delegate = self
		layoutableView.textView.text = todo?.title
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationController?.navigationBar.setColors(background: Color.white, tint: Color.skyBlue)
		navigationItem.title = todo == nil ? "New Todo" : "Edit Todo"

		navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelBarButtonItem))
		navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveBarButtonItem))
		navigationItem.rightBarButtonItem?.isEnabled = false

		layoutableView.textView.becomeFirstResponder()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		layoutableView.textView.resignFirstResponder()
	}

}

// MARK: - UITextViewDelegate
extension TodoViewController: UITextViewDelegate {

	func textViewDidChange(_ textView: UITextView) {
		let text = textView.text?.trimmed ?? ""
		navigationItem.rightBarButtonItem?.isEnabled = !text.isEmpty
	}

}

// MARK: - Actions
private extension TodoViewController {

	@objc
	func didTapCancelBarButtonItem() {
		dismiss(animated: true)
	}

	@objc
	func didTapSaveBarButtonItem() {
		guard let title = layoutableView.textView.text.trimmed, !title.isEmpty else { return }

		if var aTodo = todo {
			aTodo.title = title
			updateTodo(aTodo)
		} else {
			createTodo(title: title)
		}
	}

}

// MARK: - Networking
private extension TodoViewController {

	func createTodo(title: String) {
		guard let token = AuthCache.token?.token else { return }

		API.todoProvider.request(.create(title: title, token: token), dataType: Todo.self) { [weak self] result in
			switch result {
			case .failure(let error):
				print(error.localizedDescription)
			case .success(let todo):
				print(todo)
				self?.dismiss(animated: true)
			}
		}
	}

	func updateTodo(_ todo: Todo) {
		guard let token = AuthCache.token?.token else { return }

		API.todoProvider.request(.update(todo, token: token), dataType: Todo.self) { [weak self] result in
			switch result {
			case .failure(let error):
				print(error.localizedDescription)
			case .success(let todo):
				print(todo)
				self?.dismiss(animated: true)
			}
		}
	}

}
