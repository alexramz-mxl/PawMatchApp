//
//  PawMatchApp.swift
//  PawMatch
//
//  Created by uvminstaller on 07/02/26.
//

import SwiftUI
import SwiftData


@main
struct PawMatchApp: App {
    
    
    @State private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                HomeView(user: session.currentUser!)
            } else {
                LoginView()
            }
        }
        .environmentObject(session)
        .modelContainer(for: [User.self, Pet.self])
    }
}
