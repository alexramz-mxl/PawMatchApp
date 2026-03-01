//
//  MatchView.swift
//  PawMatch
//
//  Created by uvminstaller on 27/02/26.
//

import SwiftUI

struct MatchView: View {
    var petName: String
    
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("It's a Match!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Text(".\(petName) likes you too!")
                    .foregroundColor(.white)
                
                Image(systemName: "pawprint.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        withAnimation(.linear(duration: 0.6).repeatForever(autoreverses: true)) {
                            self.rotation = 15
                        }
                    }
            }
        }
    }
}
