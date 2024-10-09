//
//  ArtViewModel.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import Foundation

@MainActor
class ArtViewModel: Observable, ObservableObject {
    @Published var artObjects: [ArtObject] = []
    @Published var favObjects: [ArtObject] = []
    {
        didSet {
            print("Favoriten wurden geändert!")
        }
    }
    
    enum HTTPError: Error {
        case invalidURL, fetchFailed
        var message: String {
            switch self {
            case .invalidURL: "Die URL ist ungültig"
            case .fetchFailed: "Laden ist fehlgeschlagen"
            }
        }
    }
    
    func fetchArt(suche: String) {
        Task {
            do {
                guard let objectIds = try await getArtObjects(suche: suche).objectIDs else { return }
                
                for id in objectIds {
                    let artObject = try await fetchArtObjectDetails(for: id)
                    self.artObjects.append(artObject)
                }
            } catch let error as HTTPError {
                print(error.message)
            } catch {
                print(error)
            }
        }
    }
    
    private func getArtObjects(suche: String) async throws -> ArtObjectResponse {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/search?isHighlight=true&q=\(suche)"
        guard let url = URL(string: urlString) else { throw HTTPError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ArtObjectResponse.self, from: data)
    }
    
    private func fetchArtObjectDetails(for objectId: Int) async throws -> ArtObject {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(objectId)"
        guard let url = URL(string: urlString) else { throw HTTPError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ArtObject.self, from: data)
    }
    
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
