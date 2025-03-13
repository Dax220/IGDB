//
//  ContentView.swift
//  IGDB
//
//  Created by Maxim Tischenko on 11.03.2025.
//

import SwiftUI
import CoreData
import Domain
import IGDB_SWIFT_API
import Repository

struct ContentView: View {
    var body: some View {
        GamesListFactory.makeView()
    }
}

#Preview {
    ContentView()
}
