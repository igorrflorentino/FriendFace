//
//  Models.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import Foundation

struct Friend: Codable, Identifiable {
	var id: String
	var name: String
}

struct User: Codable, Identifiable {
	var id: String
	var isActive: Bool
	var name: String
	var age: Int
	var company: String
	var email: String
	var address: String
	var about: String
	var registered: String
	var tags: [String]
	var friends: [Friend]
}
