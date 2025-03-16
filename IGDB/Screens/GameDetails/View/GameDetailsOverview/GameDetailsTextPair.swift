//
//  GameDetailsTextPair.swift
//  IGDB
//
//  Created by Maxim Tischenko on 15.03.2025.
//

import SwiftUI

struct GameDetailsTextPair: View {
    
    var topText: String
    var bottomText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(topText)
                .font(.headline)
            Text(bottomText)
                .font(.footnote)
        }
        .foregroundColor(.white)
    }
}
