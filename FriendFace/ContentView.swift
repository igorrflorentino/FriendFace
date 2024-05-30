//
//  ContentView.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import SwiftUI

struct ContentView: View {
	@State var viewModel = ViewModel()
	
	var body: some View {
		NavigationStack {
			Group {
				if viewModel.isLoading {
					ProgressView("Loading...")
				} else if let errorMessage = viewModel.errorMessage {
					Text("Error: \(errorMessage)")
						.foregroundColor(.red)
				} else {
					List(viewModel.users) { user in
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
				if viewModel.users.isEmpty {
					viewModel.fetchData()
				}
			}
		}
	}
}

#Preview {
    ContentView()
}
