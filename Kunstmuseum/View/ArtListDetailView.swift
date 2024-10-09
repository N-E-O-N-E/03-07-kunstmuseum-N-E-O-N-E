//
//  ArtListDetailView.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 09.10.24.
//

import SwiftUI

struct ArtListDetailView: View {
    @EnvironmentObject var artViewModel: ArtViewModel
    @State var isActiv: Bool = false
    
    var objects: ArtObject?
    
    var body: some View {
        
        VStack(alignment:.center) {
            
            AsyncImage(url: URL(string: (objects?.primaryImage)!)) { image in
                image
                    .resizable()
                    .frame(width: 300, height: 300)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(radius: 3)
                    .padding()
            } placeholder: {
                ProgressView()
            }
            
            Text(objects!.title)
                .font(.callout).bold()
            Text(objects!.artistDisplayName)
                .font(.caption2)
            
            Divider()
            
            Text(objects!.objectID.description)
                .font(.caption2)
                .foregroundStyle(.orange)
            
                .navigationTitle("Object detail")
                .navigationBarTitleDisplayMode(.large)
        }
        .onAppear() {
            if artViewModel.isFavorite(for: objects!) {
                isActiv = true
            } else {
                isActiv = false
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isActiv = true
                    artViewModel.favObjects.append(objects!)
                    
                }) {
                    Image(systemName: isActiv ? "heart.fill" : "heart")
                        .foregroundStyle(isActiv ? .red : .gray)
                }
                // Wäre auch mit einem Image lösbar und einer If/else die
                //append oder remove nutzt jenachdem ob er etwas in der Favoritenliste hat oder nicht
            }
        }
    }
}

#Preview {
    ArtListDetailView()
}
