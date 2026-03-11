//
//  DogProfileCard.swift
//  PawMatch
//
//  Created by uvminstaller on 11/02/26.
//

import SwiftUI

struct PetProfileCard: View {
    
    
        var pet: Pet
    @State private var showPaw: Bool = false
     
    var body: some View {
        
        VStack {
            ZStack {
                
                if let data = pet.imageData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 420)
                        .clipped()
                        .cornerRadius(20)
                    
                } else {
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.black)
                        .opacity(0.85)
                        .transition(.scale)
                        .shadow(radius: 15)
                }
            }
            .onTapGesture(count: 2){
                likeAction()
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: showPaw)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(pet.name)
                    .font(.title)
                    .bold()
                
                Text("\(pet.breed) • \(pet.age) years old")
                    .foregroundColor(.gray)
                
                Text(pet.petDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                StarRatingView(rating: pet.rating)
                    .padding(.top, 8)
            }
            .padding()
            .background(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 10)
        .padding()
    }
    func likeAction() {
        pet.likes += 1
        saveLikes()
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)){
            showPaw = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            withAnimation {
                showPaw = false
            }
        }
    }
    
    func saveLikes() {
        UserDefaults.standard.set(pet.likes, forKey: pet.name)
    }
}
