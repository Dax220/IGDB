//
//  GameAboutTextItem.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import SwiftUI

struct GameAboutTextItem: View {
    
    var title: LocalizedStringKey
    var values: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
            }
            
            ForEach(values, id: \.self) { value in
                HStack {
                    Text(value)
                        .font(.caption)
                    Spacer()
                }
            }
            
            Spacer()
        }
    }
}
