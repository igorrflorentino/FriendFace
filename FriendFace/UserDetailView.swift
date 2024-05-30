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
				Text("\(user.name)")
				Text("\(user.age) years old")
				Text("\(user.company) company")
				Text("\(user.email)")
				Text("\(user.address)")
			}
			Section(header: Text("About")){
				Text(user.about)
			}
			Section(header: Text("Registered")){
				Text(user.formattedRegisteredDate)
			}
			
			Section(header: Text("Tags")) {
				//na chamada da nossa view FlowLayout nao precisamos especificar o retorno da closure passada como paramatro da construçao pois o framework SwiftUI infere automaticamente o valor
				FlowLayout(items: user.tags) { tag in
					Text(tag)
						.padding(.all, 5)
						.background(Color.blue.opacity(0.2))
						.cornerRadius(5)
				}
			}
			Section(header: Text("Friends")) {
				FlowLayout(items: user.friends) { friend in
					Text(friend.name)
						.padding(.all, 5)
						.background(Color.green.opacity(0.2))
						.cornerRadius(5)
				}
			}
		}
		.navigationTitle(user.name)
	}
}

#Preview {
	let friend1 = Friend(id: UUID(), name: "Friend1")
	let friend2 = Friend(id: UUID(), name: "Friend2")
	let friend3 = Friend(id: UUID(), name: "Friend3")
	let friend4 = Friend(id: UUID(), name: "Friend4")
	let friend5 = Friend(id: UUID(), name: "Friend5")
	let friend6 = Friend(id: UUID(), name: "Friend6")
	let user = User(id: UUID(), isActive: true, name: "User1", age: 99, company: "ACME", email: "nick@email.com", address: "00 Dumb's Road" , about: "What about", registered: .now, tags: ["S", "C", "Sw", "Xcode", "iOS", "macOS", "watchOS", "tvOS", "CoreData", "CloudKit"], friends: [friend1, friend2,friend3, friend4,friend5, friend6])
    return UserDetailView(user: user)
}
