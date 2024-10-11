//
//  ArtViewModel.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import Foundation

@MainActor
class ArtViewModel: Observable, ObservableObject {
    
    @Published var suche: String = ""
    
    @Published var artObjects: [ArtObject] = []
    @Published var favObjects: [ArtObject] = [] {
        didSet { print("Favoriten wurden geändert!") } }
    
    private let repository = ArtRepository()
    
    func addFavorite(for object: ArtObject) {
        favObjects.append(object)
        print("Favorit wurde hinzugefügt.")
        
    }
    
    func removeFavorite(for object: ArtObject) {
        if let index = favObjects.firstIndex(of: object) {
            favObjects.remove(at: index)
            print("Favorit wurde entfernt.")
        }
    }
    
    func isFavorite(for object: ArtObject) -> Bool {
        favObjects.contains(object)
    }
    
}
