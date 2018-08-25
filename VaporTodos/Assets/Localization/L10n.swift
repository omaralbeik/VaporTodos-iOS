// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
internal enum L10n {

	internal enum Auth {

		internal enum Form {

			internal enum Placeholders {
				/// Email Address
				internal static let email = L10n.tr("Localizable", "auth.form.placeholders.email")
				/// Name (Optional)
				internal static let name = L10n.tr("Localizable", "auth.form.placeholders.name")
				/// Password
				internal static let password = L10n.tr("Localizable", "auth.form.placeholders.password")
			}

			internal enum Submit {
				/// Login
				internal static let login = L10n.tr("Localizable", "auth.form.submit.login")
				/// Create Account
				internal static let register = L10n.tr("Localizable", "auth.form.submit.register")
			}
		}

		internal enum Mode {
			/// Login
			internal static let login = L10n.tr("Localizable", "auth.mode.login")
			/// Register
			internal static let register = L10n.tr("Localizable", "auth.mode.register")
		}
	}

	internal enum Generic {
		/// Unknown Server Error
		internal static let unknownServerError = L10n.tr("Localizable", "generic.unknown_server_error")
	}

	internal enum Todo {

		internal enum Details {

			internal enum Title {
				/// Edit Todo
				internal static let edit = L10n.tr("Localizable", "todo.details.title.edit")
				/// New Todo
				internal static let new = L10n.tr("Localizable", "todo.details.title.new")
			}
		}

		internal enum Listing {
			/// Logout
			internal static let logout = L10n.tr("Localizable", "todo.listing.logout")
			/// Todos
			internal static let title = L10n.tr("Localizable", "todo.listing.title")

			internal enum Cell {
				/// Delete
				internal static let delete = L10n.tr("Localizable", "todo.listing.cell.delete")
				/// Mark Done
				internal static let markDone = L10n.tr("Localizable", "todo.listing.cell.mark_done")
				/// Mark Todo
				internal static let markTodo = L10n.tr("Localizable", "todo.listing.cell.mark_todo")
			}

			internal enum LogoutAlert {
				/// You will not be able to access your todos before signing in again.
				internal static let message = L10n.tr("Localizable", "todo.listing.logout_alert.message")
				/// Logout?
				internal static let title = L10n.tr("Localizable", "todo.listing.logout_alert.title")

				internal enum Options {
					/// Cancel
					internal static let cancel = L10n.tr("Localizable", "todo.listing.logout_alert.options.cancel")
					/// Logout
					internal static let logout = L10n.tr("Localizable", "todo.listing.logout_alert.options.logout")
				}
			}
		}
	}
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
	private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
		let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
		return String(format: format, locale: Locale.current, arguments: args)
	}
}

private final class BundleToken {}
