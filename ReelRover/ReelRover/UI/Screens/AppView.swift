//
//  AppView.swift
//  ReelRover
//
//  Created by Galen Quinn on 1/29/24.
//

import SwiftUI
import SwiftData

struct AppView: View {

    var body: some View {
        TabView {
            SearchView()
                .modelContainer(for: MovieModel.self)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    AppView()
}
