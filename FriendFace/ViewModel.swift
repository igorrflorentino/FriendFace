//
//  ViewModel.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
	@Published var users = [User]()
	@Published var errorMessage: String?
	@Published var isLoading = false
	
	private var cancellable: AnyCancellable?
	private let userDefaultsKey = "cachedUsers"
	
	init() {
		loadCachedData()
	}
	
	func fetchData() {
		guard users.isEmpty else { return }
		
		errorMessage = nil
		isLoading = true
		
		let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
		
		cancellable = URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: [User].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { completion in
				self.isLoading = false
				switch completion {
				case .failure(let error):
					self.errorMessage = "Failed to load data: \(error.localizedDescription)"
				case .finished:
					break
				}
			}, receiveValue: { [weak self] users in
				self?.users = users
				self?.cacheData(users)
			})
	}
	
	private func loadCachedData() {
		if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
			if let decodedUsers = try? JSONDecoder().decode([User].self, from: data) {
				self.users = decodedUsers
			}
		}
	}
	
	private func cacheData(_ users: [User]) {
		if let encodedData = try? JSONEncoder().encode(users) {
			UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
		}
	}
}
