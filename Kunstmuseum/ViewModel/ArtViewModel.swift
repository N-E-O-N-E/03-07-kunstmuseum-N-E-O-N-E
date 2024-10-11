//
//  ArtViewModel.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import Foundation
import SwiftUICore

@MainActor
class ArtViewModel: Observable, ObservableObject {
    
    let repository = ArtRepository()
    
    @Published var suche: String = ""
    @Published var artObjects: [ArtObject] = []
    @Published var favObjects: [ArtObject] = [] {
        didSet { print("Favoriten wurden geändert!") } }
    
    
    func fetchArt() async throws {
        
        guard let objectIds = try await repository.getArtObjects(suche: suche).objectIDs else {
            throw ArtRepository.HTTPError.fetchFailed
        }
        
        for id in objectIds {
            let artObject = try await repository.fetchArtObjectDetails(for: id)
            
            self.artObjects.append(artObject)
        }
    }
    
    func addFavorite(for object: ArtObject) {
        favObjects.append(object)
        print("Favorit wurde hinzugefügt und gespeichert!")
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
    
}
