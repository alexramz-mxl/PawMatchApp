//
//  StarRatingView.swift
//  PawMatch
//
//  Created by uvminstaller on 27/02/26.
//

import SwiftUI

struct StarRatingView: View {
    var rating: Double
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= Int(rating) ? "pawprint.fill" : "pawprint")
                    .foregroundColor(.yellow)
            }
        }
    }
}
