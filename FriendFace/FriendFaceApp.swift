//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Igor Florentino on 27/05/24.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
		.modelContainer(for: User.self)
    }
}
