//
//  ContentView.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel = UserViewModel()
	
	var body: some View {
		NavigationStack {
			Group {
				if viewModel.isLoading {
					ProgressView("Loading...")
						.progressViewStyle(CircularProgressViewStyle())
				} else if let errorMessage = viewModel.errorMessage {
					VStack {
						Text(errorMessage)
							.foregroundColor(.red)
							.multilineTextAlignment(.center)
							.padding()
						
						Button("Retry") {
							viewModel.fetchData()
						}
						.padding()
					}
				} else {
					List(viewModel.users) { user in
						NavigationLink(destination: UserDetailView(user: user)) {
							HStack {
								Text(user.name)
									.font(.headline)
								Spacer()
								Text(user.isActive ? "Active" : "Inactive")
									.foregroundColor(user.isActive ? .green : .red)
							}
						}
					}
				}
			}
			.navigationTitle("FriendFace")
			.onAppear {
				viewModel.fetchData()
			}
		}
	}
}

#Preview {
    ContentView()
}
