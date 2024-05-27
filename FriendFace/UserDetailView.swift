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
    UserDetailView()
}
