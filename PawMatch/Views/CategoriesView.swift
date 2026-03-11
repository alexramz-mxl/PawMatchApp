//
//  CategoriesView.swift
//  PawMatch
//
//  Created by uvminstaller on 05/03/26.
//

import SwiftUI

struct CategoriesView: View {

    var body: some View {
        
        NavigationStack {
             
            List {
                
                Label("Dogs", systemImage: "pawprint")
                Label("Cats", systemImage: "cat")
                Label("Pets", systemImage: "hare")
                Label("Animal aid foundations", systemImage: "heart")
            }
            .navigationTitle("Categories")
        }
    }
}
