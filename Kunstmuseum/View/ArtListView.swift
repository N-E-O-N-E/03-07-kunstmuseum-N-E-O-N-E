//
//  ArtListView.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import SwiftUI

struct ArtListView: View {
    @EnvironmentObject var artViewModel: ArtViewModel
    @State var suche: String = ""
    
    var body: some View {
        HStack {
            Text("The Art Gallery").font(.title).bold()
            Spacer()
            Image("placeholder")
                .resizable()
                .frame(width: 90, height: 90)
                .clipShape(.circle)
        }.padding(15)
        
        HStack {
            TextField("Suche", text: $suche)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Suche") {
                artViewModel.artObjects.removeAll()
                Task {
                    try await artViewModel.artObjects.append(contentsOf: artViewModel.repository.fetchArt(suche: suche))
                }
            }.buttonStyle(.borderedProminent)
                .padding()
        }
        
        Divider()
        
        
        List(artViewModel.artObjects) { objects in
            NavigationLink(destination: {
                ArtListDetailView(objects: objects)
                
            }, label: {
                
                VStack(alignment:.leading) {
                    HStack {
                        AsyncImage(url: URL(string: objects.primaryImage ?? "")) { image in
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
                            
                            Text(objects.title)
                                .font(.callout).bold()
                            Text(objects.artistDisplayName)
                                .font(.caption2)
                            Text(objects.objectID.description)
                                .font(.caption2)
                                .foregroundStyle(.orange)
                            
                            if artViewModel.isFavorite(for: objects) {
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.red)
                            }
                            
                        }
                    }
                }
            })
        } //.task { do { artViewModel.fetchArt() } }
        .listStyle(.plain)
    }
}

#Preview {
    ArtListView()
}
