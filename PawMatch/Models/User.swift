//
//  User.swift
//  PawMatch
//
//  Created by uvminstaller on 14/02/26.
//

import Foundation
import SwiftData
import CryptoKit

@Model
final class User {
    
    var id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var passwordHash: String
    
    var subscriptionStatus: SubscriptionStatus
    var subscriptionExpirationDate: Date?
    
    var pets: [Pet] = []
    
    var maxPetsAllowed: Int {
        subscriptionStatus == .premium ? 5 : 3
    }
    
    var isSubscriptionActive: Bool {
        guard subscriptionStatus == .premium,
              let expiration = subscriptionExpirationDate else {
            return false
        }
        return expiration > Date()
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    init(
        id: UUID = UUID(),
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        subscriptionStatus: SubscriptionStatus = .free,
        subscriptionExpirationDate: Date? = nil
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.passwordHash = User.hashPassword(password)
        self.subscriptionStatus = subscriptionStatus
        self.subscriptionExpirationDate = subscriptionExpirationDate
    }
        static func hashPassword(_ password: String) -> String {
            let data = Data(password.utf8)
            let hash = SHA256.hash(data: data)
            return hash.compactMap { String(format: "%02x", $0)}.joined()
    }
}
