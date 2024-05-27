//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import SwiftUI

struct UserDetailView: View {
	let user: User
	
	var body: some View {
		List{
			Section(header: Text("Basic Information")){
				Text("Name: \(user.name)")
				Text("Age: \(user.age)")
				Text("Company: \(user.company)")
				Text("Email: \(user.email)")
				Text("Address: \(user.address)")
			}
			Section(header: Text("About")){
				Text(user.about)
			}
			Section(header: Text("Registered")){
				Text(user.formattedRegisteredDate)
			}
			Section(header: Text("Tags")){
				ForEach(user.tags, id: \.self) { tag in
					Text(tag)
						.padding(5)
						.background(Color.gray.opacity(0.2))
						.cornerRadius(5)
				}
			}
			Section(header: Text("Friends")){
				ForEach(user.friends) { friend in
					Text(friend.name)
				}
			}
		}
		.navigationTitle(user.name)
	}
}

#Preview {
	let friend1 = Friend(id: "01", name: "Friend1")
	let friend2 = Friend(id: "02", name: "Friend2")
	let user = User(id: "01", isActive: true, name: "User1", age: 99, company: "ACME", email: "nick@email.com", address: "00 Dumb's Road" , about: "What about", registered: "0001-01-01T01:01:01-01:01", tags: ["tag1","tag2"], friends: [friend1, friend2])
    return UserDetailView(user: user)
}
