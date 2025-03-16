//
//  CustomSegmentedControlItem.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import SwiftUI

struct CustomSegmentedControlItem {
    var title: String
    var backgroundColor: Color = .black
    var titleColor: Color = .white
    var selectedBackgroundColor: Color = .gray
    var selectedTitleColor: Color = .white
}

struct CustomSegmentedControl<T: RawRepresentable>: View where T.RawValue == Int {
    
    @Binding var selectedTab: T
    
    var items: [CustomSegmentedControlItem]
    var bgColor: Color = .black
    var font: Font = .caption
    
    var body: some View {
        HStack {
            Spacer().frame(width: 3)
            
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                
                Text(item.title).tag(index)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(
                        Rectangle()
                            .fill(
                                selectedTab.rawValue == index
                                ? item.selectedBackgroundColor
                                : item.backgroundColor
                            )
                    )
                    .foregroundColor(
                        selectedTab.rawValue == index
                        ? item.selectedTitleColor
                        : item.titleColor
                    )
                    .onTapGesture {
                        selectedTab = T(rawValue: index)!
                    }
            }
            
            Spacer().frame(width: 3)
        }
        .frame(height: 46)
        .background(
            Rectangle()
                .fill(bgColor)
        )
        .font(font)
    }
}


#Preview {
    @Previewable @State var tab = GameAboutTabs.about
    CustomSegmentedControl(
        selectedTab: $tab, items: [
            .init(title: "About"),
            .init(title: "Videos"),
            .init(title: "Screenshots"),
            .init(title: "Releases"),
        ]
    )
}
