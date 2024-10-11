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
    
    let repository = ArtRepository()
    
    func fetchArt(suche: String) async throws {
        guard let objectIds = try await repository.getArtObjects(suche: suche).objectIDs else {
            throw ArtRepository.HTTPError.fetchFailed
        }
        
        for id in objectIds {
            let artObject = try await repository.fetchArtObjectDetails(for: id)
            self.artObjects.append(artObject)
        }
    }
    
//    func fetchArt(suche: String) async throws -> [ArtObject] {
//        var objects: [ArtObject] = []
//            do {
//                guard let objectIds = try await repository.getArtObjects(suche: suche).objectIDs else {
//                    throw ArtRepository.HTTPError.fetchFailed
//                }
//                
//                for id in objectIds {
//                    let artObject = try await repository.fetchArtObjectDetails(for: id)
//                    objects.append(artObject)
//                }
//            } catch {
//                print(ArtRepository.HTTPError.fetchFailed.message)
//            }
//        return objects
//    }
    
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
