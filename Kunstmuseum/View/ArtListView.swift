//
//  ArtListView.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import SwiftUI

struct ArtListView: View {
    @EnvironmentObject var artViewModel: ArtViewModel
    @State var buttonInactive: Bool = true
    
    var body: some View {
        HStack {
            Text("The Art Gallery").font(.title).bold().shadow(color: .purple, radius: 20)
            Spacer()
            Image("placeholder")
                .resizable()
                .frame(width: 140, height: 90)
                .clipShape(.rect(cornerRadius: 0))
                .border(.black)
                .shadow(radius: 2)
        }.padding(15)
        
        HStack {
            TextField("Suche", text: $artViewModel.suche)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Suche") {
                artViewModel.artObjects.removeAll()
                Task {
                    try await artViewModel.fetchArt(suche: artViewModel.suche)
                }
            }.buttonStyle(.borderedProminent).disabled(buttonInactive)
                .padding()
                .onChange(of: artViewModel.suche) { oldValue, newValue in
                    if !artViewModel.suche.isEmpty {
                        buttonInactive = false
                    } else {
                        buttonInactive = true
                    }
                }
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
        .onAppear(){
            buttonInactive = true
            artViewModel.suche = ""
        }
    }
}

#Preview {
    ArtListView()
        .environment(ArtViewModel())
}
