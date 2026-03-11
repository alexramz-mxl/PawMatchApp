//
//  Dog.swift
//  PawMatch
//
//  Created by uvminstaller on 11/02/26.
//

import Foundation
import SwiftData

@Model
final class Pet {
    var id: UUID
    var name: String
    var breed: String
    var age: Int
    var petDescription: String
    var imageData: Data?
    var likes: Int
    var isBoostActive: Bool
    var boostExpirationDate: Date?
    
    @Relationship(inverse: \User.pets)
    var owner: User?
    
    var rating: Double {
        let baseRating = min(Double(likes) / 10.0, 5.0)
        return isBoostActive ? min(baseRating + 0.5, 5.0) : baseRating
    }
    
    init(
        id: UUID = UUID(),
        name: String,
        breed: String,
        age: Int,
        petDescription: String,
        imageData: Data? = nil,
        likes: Int = 0,
        isBoostActive: Bool = false,
        boostExpirationDate: Date? = nil,
        owner: User? = nil
    ) {
        self.id = id
        self.name = name
        self.breed = breed
        self.age = age
        self.petDescription = petDescription
        self.imageData = imageData
        self.likes = likes
        self.isBoostActive = isBoostActive
        self.boostExpirationDate = boostExpirationDate
        self.owner = owner
    }
}
