//
//  ProfileView.swift
//  PawMatch
//
//  Created by uvminstaller on 28/02/26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    var user: User
    @Environment(\.modelContext) private var modelContext
    
    @State private var showAddPet = false
    @State private var showEditProfile = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.appPink, Color.appOrange],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        
                        VStack {
                            
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(.appPink)
                                .shadow(radius: 10)
                            
                            Text(user.fullName)
                                .font(.title)
                                .bold()
                                .foregroundColor(.textGray)
                            
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        
                        VStack(spacing: 8) {
                            
                            Text("Account Type")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(user.subscriptionStatus.rawValue.capitalized)
                                .font(.body)
                                .foregroundColor(user.subscriptionStatus == .premium ? .yellow : .white
                                )
                            if user.subscriptionStatus == .premium {
                                Text("Premium subscription active")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                        }
                        
                        Divider()
                            .background(Color.black.opacity(0.5))
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            HStack {
                                Text("Your currently registered pets")
                                    .font(.headline)
                                    .foregroundColor(.appPink)
                                
                                Spacer()
                                
                                Text("Registered pets: \(user.pets.count)/\(user.maxPetsAllowed)")
                                    .foregroundColor(.appOrange.opacity(0.9))
                            }
                        }
                        
                        Divider()
                            .background(Color.black.opacity(0.5))
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            HStack {
                                Text("You currently registered pets \(user.pets.count)/\(user.maxPetsAllowed)")
                                    .font(.headline)
                                    .foregroundColor(.appOrange.opacity(0.9))
                                
                                Spacer()
                                
                                Button {
                                    showAddPet = true
                                } label: {
                                    Label("Add Pet", systemImage: "plus")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddPet) {
            AddPetView(user: user)
        }
    }
}
