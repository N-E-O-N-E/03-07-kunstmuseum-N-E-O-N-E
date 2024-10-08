//
//  ArtListView.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import SwiftUI

struct ArtListView: View {
    @StateObject var artViewModel = ArtViewModel()
    
    var body: some View {
        HStack {
            Text("The Art Gallery").font(.title).bold()
            Spacer()
            Image("placeholder")
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(.circle)
        }.padding()
        Divider()
        List(artViewModel.artObjects) { objects in
            VStack {
                AsyncImage(url: URL(string: objects.primaryImage ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(radius: 3)
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                Text(objects.title)
                    .font(.headline).bold()
                Text(objects.artistDisplayName)
                    .font(.subheadline)
            }
        }.task { do { artViewModel.fetchArt() } }
            .listStyle(.plain)
    }
}

#Preview {
    ArtListView()
}
