//
//  TodosViewController.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/24/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class TodosViewController: ViewController, Layouting {
	typealias ViewType = TodosView

	var todos: [Todo] = []

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutableView.tableView.dataSource = self
		layoutableView.tableView.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		fetchTodos()

		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.prefersLargeTitles = true
		}

		navigationController?.navigationBar.setColors(background: Color.white, tint: Color.skyBlue)
		navigationItem.title = L10n.Todo.Listing.title
		navigationItem.leftBarButtonItem = .init(title: L10n.Todo.Listing.logout, style: .plain, target: self, action: #selector(didTapLogoutBarButtonItem))
		navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(didTapAddBarButtonItem))
	}

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension TodosViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todos.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.reuseIdentifier) as! TodoTableViewCell
		cell.configure(for: todos[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let deleteAction = UITableViewRowAction(style: .destructive, title: L10n.Todo.Listing.Cell.delete) { [weak self] _, indexPath in
			self?.deleteTodo(indexPath: indexPath)
		}
		deleteAction.backgroundColor = Color.red

		let doAction = UITableViewRowAction(style: .normal, title: L10n.Todo.Listing.Cell.markDone) { [weak self] _, indexPath in
			self?.markTodo(indexPath: indexPath, isDone: true)
		}
		doAction.backgroundColor = Color.green

		let undoAction = UITableViewRowAction(style: .normal, title: L10n.Todo.Listing.Cell.markTodo) { [weak self] _, indexPath in
			self?.markTodo(indexPath: indexPath, isDone: false)
		}
		undoAction.backgroundColor = Color.yellow

		var actions = [deleteAction]

		let isDone = todos[indexPath.row].isDone
		actions.append(isDone ? undoAction : doAction)

		return actions
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		showTodoViewController(todo: todos[indexPath.row])
	}

}

// MARK: - Actions
private extension TodosViewController {

	@objc
	func didTapLogoutBarButtonItem() {
		let alert = UIAlertController(title: L10n.Todo.Listing.LogoutAlert.title, message: L10n.Todo.Listing.LogoutAlert.message, preferredStyle: .alert)

		let logoutAction = UIAlertAction(title: L10n.Todo.Listing.LogoutAlert.Options.logout, style: .destructive) { _ in
			AuthCache.token = nil
			(UIApplication.shared.delegate as! AppDelegate).showAuthController()
		}
		alert.addAction(logoutAction)

		let cancelAction = UIAlertAction(title: L10n.Todo.Listing.LogoutAlert.Options.cancel, style: .cancel, handler: nil)
		alert.addAction(cancelAction)

		present(alert, animated: true)
	}

	@objc
	func didTapAddBarButtonItem() {
		showTodoViewController()
	}

}

// MARK: - Helpers
private extension TodosViewController {

	func showTodoViewController(todo: Todo? = nil) {
		let todoController = TodoViewController()
		todoController.todo = todo
		let navigationController = UINavigationController(rootViewController: todoController)
		present(navigationController, animated: true)
	}

}

// MARK: - Networking
private extension TodosViewController {

	func fetchTodos(sender: Loadingable? = nil) {
		guard let token = AuthCache.token?.token else { return }

		sender?.setLoading(true)
		API.todoProvider.request(.all(token: token), dataType: [Todo].self) { [weak self] result in
			sender?.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(error: error).show()
			case .success(let todos):
				self?.todos = todos
				self?.layoutableView.tableView.reloadData()
			}
		}
	}

	func markTodo(sender: Loadingable? = nil, indexPath: IndexPath, isDone: Bool) {
		guard let token = AuthCache.token?.token else { return }
		var updatedTodo = todos[indexPath.row]
		updatedTodo.isDone.toggle()

		sender?.setLoading(true)
		API.todoProvider.request(.update(updatedTodo, token: token), dataType: Todo.self) { [weak self] result in
			sender?.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(error: error).show()
			case .success(let todo):
				guard let strongSelf = self else { return }
				strongSelf.todos[indexPath.row] = todo
				strongSelf.layoutableView.tableView.reloadRows(at: [indexPath], with: .automatic)
			}
		}
	}

	func deleteTodo(sender: Loadingable? = nil, indexPath: IndexPath) {
		guard let token = AuthCache.token?.token else { return }

		sender?.setLoading(true)
		API.todoProvider.request(TodoService.delete(todos[indexPath.row], token: token)) { [weak self] result in
			sender?.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(error: error).show()
			case .success:
				guard let strongSelf = self else { return }
				strongSelf.todos.remove(at: indexPath.row)
				strongSelf.layoutableView.tableView.deleteRows(at: [indexPath], with: .automatic)
			}
		}
	}

}
