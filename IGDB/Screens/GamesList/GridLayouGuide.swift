//
//  GridLayouGuide.swift
//  IGDB
//
//  Created by Maxim Tischenko on 16.03.2025.
//

import SwiftUI

struct GridLayouGuide {
    
    static let spacing: CGFloat = 10
    static let columns = 2
    static let HPadding: CGFloat = 20
    
    static var itemHeight: CGFloat = {
        let screenWidth =  UIScreen.main.bounds.width
        let totalPadding = HPadding * 2
        let itemsSpacing = CGFloat((columns - 1)) * spacing
        let sideRatio = 0.75
        let usedWidth = screenWidth - totalPadding - itemsSpacing
        let itemWidth = usedWidth / CGFloat(columns)
        let result = itemWidth / sideRatio
        return result
    }()
}
