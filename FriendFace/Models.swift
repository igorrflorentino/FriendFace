//
//  Models.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import Foundation

struct User: Codable, Identifiable {
	let id: String
	let isActive: Bool
	let name: String
	let age: Int
	let company: String
	let email: String
	let address: String
	let about: String
	let registered: String
	let tags: [String]
	let friends: [Friend]
	
	var formattedRegisteredDate: String {
		let isoFormatter = ISO8601DateFormatter()
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
		
		if let date = isoFormatter.date(from: registered) {
			return dateFormatter.string(from: date)
		} else {
			return registered
		}
	}
}

struct Friend: Codable, Identifiable {
	let id: String
	let name: String
}
