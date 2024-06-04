//
//  ContentView.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	@State var viewModel = ViewModel()
	@Environment(\.modelContext) var modelContext
	@Query(sort: \User.name) var users: [User]
	
	
	var body: some View {
		NavigationStack {
			Group {
				if viewModel.isLoading {
					ProgressView("Loading...")
				} else if let errorMessage = viewModel.errorMessage {
					Text("Error: \(errorMessage)")
						.foregroundColor(.red)
				} else {
					List(users) { user in
						NavigationLink(destination: UserDetailView(user: user)) {
							VStack(alignment: .leading) {
								Text(user.name)
									.font(.headline)
								Text(user.isActive ? "Active" : "Inactive")
									.font(.subheadline)
									.foregroundColor(user.isActive ? .green : .red)
							}
						}
					}
				}
			}
			.navigationTitle("FriendFace")
			.onAppear {
				if users.isEmpty {
					do{
						try viewModel.fetchData(in: modelContext)
					}catch{
						print(error.localizedDescription)
					}
				}
				
			}
		}
	}
}

#Preview {
    ContentView()
		.modelContainer(for: User.self)
}
