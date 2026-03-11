//
//  SessionManager.swift
//  PawMatch
//
//  Created by uvminstaller on 02/03/26.
//

import Foundation
import SwiftData


class SessionManager: ObservableObject {
    @Published var currentUser: User?
    
    var isLoggedIn: Bool {
        currentUser != nil
    }
    
    func login(user: User) {
        currentUser = user
    }
    
    func logout() {
        currentUser = nil
    }
    
    var isPremium: Bool {
        currentUser?.isSubscriptionActive ?? false
    }
    
    var maxPetsAllowed: Int {
        currentUser?.maxPetsAllowed ?? 0
    }
}
