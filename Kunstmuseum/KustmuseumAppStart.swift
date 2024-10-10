//
//  KustmuseumAppStart.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import SwiftUI

struct KustmuseumAppStart: View {
    @StateObject var artViewModel = ArtViewModel(repository: ArtRepository())
    
    var body: some View {
        TabView {
            Tab("About", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Art list", systemImage: "text.below.photo.fill") {
                NavigationStack {
                    ArtListView()
                }
            }
            Tab("Favorites", systemImage: "star.fill") {
                NavigationStack {
                    FavoritesView()
                }
            }
        }.tint(.purple)
            .environment(artViewModel)
    }
}

#Preview {
    KustmuseumAppStart()
}

