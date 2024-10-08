//
//  KustmuseumAppStart.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import SwiftUI

struct KustmuseumAppStart: View {
    var body: some View {
        TabView {
            Tab("About", systemImage: "house.fill") {
                HomeView()
            }
            Tab("Art List", systemImage: "text.below.photo.fill") {
                ArtListView()
            }
        }.tint(.purple)      
    }
}

#Preview {
    KustmuseumAppStart()
}

