//
//  File.swift
//  IGDB
//
//  Created by Maxim Tischenko on 15.03.2025.
//


import SwiftUI

private struct NavigationPathKey: EnvironmentKey {
    static let defaultValue: Binding<NavigationPath> = .constant(NavigationPath())
}

extension EnvironmentValues {
    var navigationPath: Binding<NavigationPath> {
        get { self[NavigationPathKey.self] }
        set { self[NavigationPathKey.self] = newValue }
    }
}
