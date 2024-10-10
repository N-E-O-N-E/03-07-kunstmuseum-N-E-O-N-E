//
//  FavoritesView.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 09.10.24.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var artViewModel: ArtViewModel
    
    var body: some View {
        
        if artViewModel.favObjects.isEmpty {
            List() {
                Text("Keine Favoriten gefunden")
            }
            .navigationTitle("My Favorites ★")
            .navigationBarTitleDisplayMode(.large)
            
        } else {
            
            
            List(artViewModel.favObjects) { favorite in
                    VStack(alignment:.leading) {
                        HStack {
                            AsyncImage(url: URL(string: favorite.primaryImage ?? "")) { image in
                                image
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .shadow(radius: 3)
                                    .padding()
                            } placeholder: {
                                ProgressView()
                            }
                            
                            
                            VStack(alignment: .leading) {
                                
                                Text(favorite.title)
                                    .font(.callout).bold()
                                Text(favorite.artistDisplayName)
                                    .font(.caption2)
                                Text(favorite.objectID.description)
                                    .font(.caption2)
                                    .foregroundStyle(.orange)
                            }
                        }
                    }.swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            artViewModel.removeFavorite(for: favorite)
                        } label: {
                            Text("Löschen")
                        }
                    }
                   
            }.listStyle(.plain)
            
            .navigationTitle("My Favorites ★")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    FavoritesView()
}
