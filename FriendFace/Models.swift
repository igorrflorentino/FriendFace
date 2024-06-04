//
//  Models.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import Foundation
import SwiftData

@Model
class User: Codable {
	enum CodingKeys: CodingKey{
		case id
		case isActive
		case name
		case age
		case company
		case email
		case address
		case about
		case registered
		case tags
		case friends
	}
	
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
	
	init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: Date, tags: [String], friends: [Friend]){
		self.id = id
		self.isActive = isActive
		self.name = name
		self.age = age
		self.company = company
		self.email = email
		self.address = address
		self.about = about
		self.registered = registered
		self.tags = tags
		self.friends = friends
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(UUID.self, forKey: .id)
		self.isActive = try container.decode(Bool.self, forKey: .isActive)
		self.name = try container.decode(String.self, forKey: .name)
		self.age = try container.decode(Int.self, forKey: .age)
		self.company = try container.decode(String.self, forKey: .company)
		self.email = try container.decode(String.self, forKey: .email)
		self.address = try container.decode(String.self, forKey: .address)
		self.about = try container.decode(String.self, forKey: .about)
		self.registered = try container.decode(Date.self, forKey: .registered)
		self.tags = try container.decode([String].self, forKey: .tags)
		self.friends = try container.decode([Friend].self, forKey: .friends)
	}
	
	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.id, forKey: .id)
		try container.encode(self.isActive, forKey: .isActive)
		try container.encode(self.name, forKey: .name)
		try container.encode(self.age, forKey: .age)
		try container.encode(self.company, forKey: .company)
		try container.encode(self.email, forKey: .email)
		try container.encode(self.address, forKey: .address)
		try container.encode(self.about, forKey: .about)
		try container.encode(self.registered, forKey: .registered)
		try container.encode(self.tags, forKey: .tags)
		try container.encode(self.friends, forKey: .friends)
	}
	
}

@Model
class Friend: Codable {
	enum CodingKeys: CodingKey{
		case id
		case name
	}
	
	let id: UUID
	let name: String
	
	init(id: UUID, name: String){
		self.id = id
		self.name = name
	}
	
	required init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(UUID.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
	}
	
	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(self.id, forKey: .id)
		try container.encode(self.name, forKey: .name)
	}
}
