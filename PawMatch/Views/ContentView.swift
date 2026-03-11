//
//  ContentView.swift
//  PawMatch
//
//  Created by uvminstaller on 07/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var pets: [Pet]
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var session: SessionManager
    
    @State private var currentIndex: Int = 0
    @State private var showMatch: Bool = false
    
    var body: some View {
        ZStack {
            
            LinearGradient( colors: [Color.pink.opacity(0.3), Color.orange.opacity(0.3)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            
        VStack {
            HStack {
                Text("Hello, \(session.currentUser?.firstName ?? "")")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if session.currentUser?.isSubscriptionActive == true {
                    Text("You're a premium user!")
                        .font(.caption)
                        .padding(6)
                        .background(.yellow.opacity(0.2))
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()

            ZStack {
                if !pets.isEmpty {
                    PetProfileCard(pet: pets[currentIndex])
                }
            }
            
            Spacer()
            
            if currentIndex < pets.count {
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
                        .background(
                            LinearGradient(
                                colors: [Color.pink, Color.orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(radius: 5 )
                    }
                    .padding(.bottom, 50)
                }
            }
            
            if showMatch && currentIndex < pets.count {
                MatchView(petName: pets[currentIndex].name)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(10)
            }
        }
        .animation(.easeInOut, value: currentIndex)
        .animation(.easeInOut, value: showMatch)
        .onAppear {
            insertSamplePetsIfNeeded()
        }
    }
    
    func givePaw() {
        guard currentIndex < pets.count else { return }
        
        pets[currentIndex].likes += 1
        
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

    func insertSamplePetsIfNeeded() {
        if pets.isEmpty {
            let pet1 = Pet(
                name: "Chispita",
                breed: "Border Collie",
                age: 2,
                petDescription: "Loves parks treats and long walks around the beach",
                imageData: nil,
                likes: 0
        )
            let pet2 = Pet(
                name: "Bruno",
                breed: "Schnauzer",
                age: 3,
                petDescription: "Sometimes grumpy but loyal and calm companion",
                imageData: nil,
                likes: 0
                )
            modelContext.insert(pet1)
            modelContext.insert(pet2)
        }
    }
}
