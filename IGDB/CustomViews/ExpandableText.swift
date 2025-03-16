//
//  ExpandableText.swift
//  IGDB
//
//  Created by Maxim Tischenko on 15.03.2025.
//

import SwiftUI

struct ExpandableText: View {
    
    @State private var isExpanded: Bool = false
    @State private var isTruncated = false
    
    init(_ text: String) {
        self.text = text
    }
    
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(text)
                .lineLimit(isExpanded ? nil : 3)
                .background(
                    ViewThatFits(in: .vertical) {
                        Text(text)
                            .hidden()
                        Color.clear
                            .onAppear {
                                isTruncated = true
                            }
                    }
                )
            
            if isTruncated == true {
                Text(isExpanded ? "expandable-text.less" : "expandable-text.more")
                    .foregroundColor(.appAccent)
                    .fontWeight(.bold)
                    .onTapGesture {
                        isExpanded.toggle()
                    }
            }
        }
    }
}
