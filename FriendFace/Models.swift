//
//  Models.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
	let id: UUID
	let isActive: Bool
	let name: String
	let age: Int
	let company: String
	let email: String
	let address: String
	let about: String
	let registered: Date
	let tags: [String]
	let friends: [Friend]
	
	var formattedRegisteredDate: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .full
		dateFormatter.timeStyle = .full
		return dateFormatter.string(from: registered)
	}
}

struct Friend: Codable, Identifiable, Hashable {
	let id: UUID
	let name: String
}
