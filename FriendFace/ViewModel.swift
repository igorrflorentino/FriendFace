//
//  ViewModel.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import SwiftUI
import Combine
import Observation

@Observable
class ViewModel {
	var users = [User]()
	var isLoading = false
	var errorMessage: String?
	var cancellables = Set<AnyCancellable>()
	
	func fetchData() {
		guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
			self.errorMessage = "Invalid URL"
			return
		}
		
		isLoading = true
		errorMessage = nil
		
		URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: [User].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { completion in
				self.isLoading = false
				if case .failure(let error) = completion {
					self.errorMessage = error.localizedDescription
				}
			}, receiveValue: { fetchedUsers in
				self.users = fetchedUsers
			})
			.store(in: &cancellables)
	}
}
