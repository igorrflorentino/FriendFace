//
//  ViewModel.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import SwiftUI
import Combine
import Observation
import SwiftData

@Observable
class ViewModel {
	var isLoading = false
	var errorMessage: String?
	var cancellables = Set<AnyCancellable>()
	
	func fetchData(in modelContext: ModelContext) throws {
		guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
			self.errorMessage = "Invalid URL"
			return
		}
		
		isLoading = true
		errorMessage = nil
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		
		let insertContext = ModelContext(modelContext.container)
		
		URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: [User].self, decoder: decoder)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { completion in
				self.isLoading = false
				if case .failure(let error) = completion {
					self.errorMessage = error.localizedDescription
				}
			}, receiveValue: { fetchedUsers in
				for user in fetchedUsers{
					insertContext.insert(user)
				}
			})
			.store(in: &cancellables)
		try insertContext.save()
	}
}
