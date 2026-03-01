//
//  HomeView.swift
//  PawMatch
//
//  Created by uvminstaller on 16/02/26.
//

import SwiftUI

struct HomeView: View {
    var user: User
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Lets Match!", systemImage: "pawprint")
                }
            ProfileView(user: user)
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            SettingsView(user: user)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}
