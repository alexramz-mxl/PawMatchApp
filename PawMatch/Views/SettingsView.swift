//
//  SettingsView.swift
//  PawMatch
//
//  Created by uvminstaller on 28/02/26.
//

import SwiftUI

struct SettingsView: View {
    var user: User
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("searchRadius") private var searchRadius: Double = 10
    @AppStorage("minAge") private var minAge: Double = 1
    @AppStorage("maxAge") private var maxAge: Double = 10
    @AppStorage("isBoostEnabled") private var isBoostEnabled: Bool = false
    @AppStorage("subscriptionStatus") private var subscriptionStatus: String = "free"
    
    var body: some View {
        
            Form {
                
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section("Search Radius") {
                    VStack(alignment: .leading) {
                        Text("Distance: \(Int(searchRadius)) km")
                        Slider(value: $searchRadius, in: 1...100, step: 1)
                    }
                }
                
                Section("Pet age filter") {
                    VStack(alignment: .leading) {
                        Text("Minimum age: \(Int(minAge)) years")
                        Slider(value: $minAge, in: 1...10, step: 1)
                    }
                    VStack(alignment: .leading) {
                        Text("Maximum age: \(Int(maxAge)) years")
                        Slider(value: $maxAge, in: 1...10, step: 1)
                    }
                }
                
                Section("Boost") {
                    Toggle("Boost enabled", isOn: $isBoostEnabled)
                }
                
                Section("Subscription") {
                    HStack {
                        Text("Current Plan: \(subscriptionStatus)")
                        Spacer()
                        Text(subscriptionStatus.capitalized)
                            .foregroundColor(subscriptionStatus == "PREMIUM" ? .pink : .gray)
                            .fontWeight(.bold)
                    }
                    
                    Button("Upgrade to premium!") {
                        subscriptionStatus = "PREMIUM"
                    }
                    .foregroundColor(.pink)
                }
            }
            .navigationTitle("Settings")
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
