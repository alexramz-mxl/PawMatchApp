//
//  ContentView.swift
//  PawMatch
//
//  Created by uvminstaller on 07/02/26.
//

import SwiftUI

struct ContentView: View {
    @State private var pets: [Pet] = [
    Pet(
        name: "Chispita",
        breed: "Border Collie",
        age: 2,
        petDescription:"Loves parks, treats and long walks around the beach she is a very playful and energetic dog.",
        imageName: "dog1",
        likes: 0
    ),
    Pet(
        name: "Bruno",
        breed: "Poodle",
        age: 5,
        petDescription:"Loves parks, treats and long walks around the beach she is a very playful and energetic dog.",
        imageName: "dog2",
        likes: 0
    )
]
    @State private var currentIndex: Int = 0
    @State private var showMatch: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient (
                colors: [Color.pink.opacity(0.3), Color.orange.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ForEach(currentIndex..<pets.count, id: \.self) { index in
                PetProfileCard(pet: $pets[index])
                    .offset(x: 0, y: Double(index - currentIndex) * 10)
                    .scaleEffect(1.0 - CGFloat( index - currentIndex) * 0.05)
                    .zIndex(Double(pets.count - index))
            }
            
            if currentIndex < pets.count {
                VStack {
                    Spacer()
                    Button(action: {
                        givePaw()
                    }) {
                        HStack {
                            Image(systemName: "pawprint.fill")
                                .font(.title)
                            Text("Paw!")
                                .font(.title2)
                                .bold()
                        }
                        .padding()
                        .frame(width:180)
                        .background(LinearGradient(colors: [Color.pink, Color.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                    }
                    .padding(.bottom, 50)
                }
                .transition(.move(edge: .bottom))
            }
            
            if showMatch {
                MatchView(petName: pets[currentIndex].name)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(10)
            }
        }
        .animation(.easeInOut, value: currentIndex)
        .animation(.easeInOut, value: showMatch)
    }
    
    func givePaw() {
        pets[currentIndex].likes += 1
        UserDefaults.standard.set(pets[currentIndex].likes, forKey: pets[currentIndex].name)
        
        if pets[currentIndex].likes % 3 == 0 {
            withAnimation {
                showMatch = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    showMatch = false
                    nextPet()
                }
            }
        } else {
            nextPet()
        }
    }
    
    func nextPet() {
        if currentIndex + 1 < pets.count {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }
}
