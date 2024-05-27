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
		VStack(alignment: .leading) {
			Text(user.name)
				.font(.largeTitle)
				.padding(.bottom)
			
			Text("Registered: \(user.formattedRegisteredDate)")
				.padding(.bottom)
			
			Text(user.about)
				.padding(.bottom)
			
			Text("Friends")
				.font(.headline)
			
			List(user.friends) { friend in
				Text(friend.name)
			}
		}
		.padding()
		.navigationTitle(user.name)
	}
}
#Preview {
	let friend1 = Friend(id: "01", name: "Friend1")
	let friend2 = Friend(id: "02", name: "Friend2")
	let user = User(id: "01", isActive: true, name: "User1", age: 99, company: "ACME", email: "nick@email.com", address: "00 Dumb's Road" , about: "What about", registered: "0001-01-01T01:01:01-01:01", tags: ["tag1","tag2"], friends: [friend1, friend2])
    return UserDetailView(user: user)
}
