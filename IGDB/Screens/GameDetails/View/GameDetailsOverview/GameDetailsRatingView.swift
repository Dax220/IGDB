//
//  RatingView.swift
//  IGDB
//
//  Created by Maxim Tischenko on 15.03.2025.
//

import SwiftUI

struct GameDetailsRatingView: View {
    
    @EnvironmentObject var viewModel: GameDetailsViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.yellow)
                    Text(viewModel.rating)
                }
                if let ratingCount = viewModel.ratingCount {
                    HStack {
                        Text("\(ratingCount)")
                        Text("rating.user-rating")
                    }
                }
            }
            Spacer()
            if let aggregatedRating = viewModel.aggregatedRating {
                VStack(alignment: .trailing) {
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.yellow)
                        Text("\(aggregatedRating)")
                    }
                    if let aggregatedRatingCount = viewModel.aggregatedRatingCount {
                        HStack {
                            Text("\(aggregatedRatingCount)")
                            Text("rating.critic-rating")
                        }
                    }
                }
            }
        }
        .padding(8)
        .background(Color.black)
        .foregroundColor(.white)
    }
}
