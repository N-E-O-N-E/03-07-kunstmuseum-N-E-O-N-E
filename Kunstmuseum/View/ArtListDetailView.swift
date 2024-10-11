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
            
            Divider()
            
            Grid(alignment: .leading) {
                
                GridRow {
                    Text("Title: ")
                        .font(.callout).bold()
                    Text("\(objects!.title)")
                        .font(.callout).bold()
                }
                GridRow {
                    Text("Artist: ")
                        .font(.caption2)
                    Text("\(objects!.artistDisplayName)")
                        .font(.caption2)
                }
                GridRow {
                    Text("Department: ")
                        .font(.caption2)
                    Text("\(objects!.department)")
                        .font(.caption2)
                    
                }
                GridRow {
                    Text("Repository: ")
                        .font(.caption2)
                    Text("\(objects!.repository)")
                        .font(.caption2)
                    
                }
                GridRow {
                    Text("Artist Bio: ")
                        .font(.caption2)
                    Text("\(objects!.artistDisplayBio)")
                        .font(.caption2)
                }
            }.padding(15)

            Divider()
            
            Text("Object-ID: \(objects!.objectID.description)")
                .font(.caption2)
                .foregroundStyle(.orange)
            
                .navigationTitle("Object detail")
                .navigationBarTitleDisplayMode(.large)
            
            Spacer()
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
        .environment(ArtViewModel())
}
