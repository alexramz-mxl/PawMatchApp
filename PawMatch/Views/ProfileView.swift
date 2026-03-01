//
//  ProfileView.swift
//  PawMatch
//
//  Created by uvminstaller on 28/02/26.
//

import SwiftUI

struct ProfileView: View {
    var user: User
    @State private var navigateToSettings: Bool = false
    
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
                    VStack(spacing: 25) {
                        
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
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                        
                        VStack(spacing: 10) {
                            
                            Text("Account Type")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(user.subscriptionStatus.rawValue.capitalized)
                                .font(.body)
                                .foregroundColor(user.subscriptionStatus == .premium ? .yellow : .white
                                )
                            if user.subscriptionStatus == .free {
                                Button("Upgrade to premium") {
                                    navigateToSettings = true
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .foregroundColor(.appPink)
                                .cornerRadius(15)
                            }
                        }
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("Your currently registered pets")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("Registered pets: .\(user.pets.count)")
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text("Max allowed: .\(user.maxPetsAllowed)")
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text(user.isSubscriptionActive ? "Subscription Active" : "Subscription Inactive")
                                .foregroundColor(user.isSubscriptionActive ?.green : .red)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer(minLength: 40)
                    }
                    .padding()
                }
            }
            .navigationDestination(isPresented: $navigateToSettings) {
                SettingsView(user: user)
            }
        }
    }
}
