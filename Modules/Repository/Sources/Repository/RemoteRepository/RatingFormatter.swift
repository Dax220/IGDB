//
//  RatingFormatter.swift
//  Repository
//
//  Created by Maxim Tischenko on 12.03.2025.
//

import Foundation

class RatingFormatter {
    
    func roundRating(
        value: Double,
        minimumFractionDigits: Int = 0,
        maximumFractionDigits: Int = 1
    ) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.locale = Locale(identifier: "en_US")

        return formatter.string(from: NSNumber(value: value / 10)) ?? "N/A"
    }
}
