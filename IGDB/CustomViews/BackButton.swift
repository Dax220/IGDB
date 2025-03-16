//
//  BackButton.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
                .padding(10)
                .background(
                    VisualEffectBlur(blurStyle: .systemUltraThinMaterialDark)
                        .clipShape(Circle())
                )
        }
        .padding(.leading, 16)
        .buttonStyle(.plain)
    }
}
