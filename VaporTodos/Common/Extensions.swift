//
//  Extensions.swift
//  VaporTodos
//
//  Created by Omar Albeik on 8/25/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import Moya
import Result

extension String {

	var base64String: String {
		return Data(utf8).base64EncodedString()
	}

	var trimmed: String? {
		let text = trimmingCharacters(in: .whitespacesAndNewlines)
		return text.isEmpty ? nil : text
	}

}

extension Date {

	func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}

}

extension UserDefaults {

	func object<T: Codable>(_ type: T.Type, with key: String) -> T? {
		guard let data = self.value(forKey: key) as? Data else { return nil }
		return try? JSONDecoder().decode(type.self, from: data)
	}

	func set<T: Codable>(object: T, forKey key: String) {
		let data = try? JSONEncoder().encode(object)
		self.set(data, forKey: key)
	}

}

extension UIWindow {

	func switchRootViewController(
		to viewController: UIViewController,
		animated: Bool = true,
		duration: TimeInterval = 0.5,
		options: UIViewAnimationOptions = .transitionFlipFromRight,
		_ completion: (() -> Void)? = nil) {

		guard animated else {
			rootViewController = viewController
			completion?()
			return
		}

		UIView.transition(with: self, duration: duration, options: options, animations: {
			let oldState = UIView.areAnimationsEnabled
			UIView.setAnimationsEnabled(false)
			self.rootViewController = viewController
			UIView.setAnimationsEnabled(oldState)
		}, completion: { _ in
			completion?()
		})
	}

}

extension UIColor {

	convenience init(hex: Int) {
		let components = (
			R: CGFloat((hex >> 16) & 0xff) / 255,
			G: CGFloat((hex >> 08) & 0xff) / 255,
			B: CGFloat((hex >> 00) & 0xff) / 255
		)
		self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
	}

}

extension UINavigationBar {

	func setColors(background: UIColor, tint: UIColor) {
		backgroundColor = background
		barTintColor = background
		tintColor = tint
	}

}

extension MoyaProvider {

	func request<T: Decodable>(_ target: Target, dataType: T.Type, completion: @escaping (_ result: Result<T, APIError>) -> Void) {
		request(target) { result in
			switch result {
			case .failure(let error):
				completion(Result.failure(APIError.moya(error)))
			case .success(let response):
				do {
					let object = try response.map(T.self, using: DefaultDecoder())
					completion(.success(object))
				} catch {
					guard let errorResponse = try? response.map(ErrorResponse.self, using: DefaultDecoder()) else {
						completion(.failure(.decoding(error)))
						return
					}
					completion(.failure(.server(errorResponse.reason)))
				}
			}
		}
	}

}
