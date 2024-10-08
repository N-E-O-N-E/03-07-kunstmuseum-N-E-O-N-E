//
//  ArtViewModel.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import Foundation

@MainActor
class ArtViewModel: ObservableObject {
    @Published var artObjects: [ArtObject] = []
    
    enum HTTPError: Error {
        case invalidURL, fetchFailed
        
        var message: String {
            switch self {
            case .invalidURL: "Die URL ist ungültig"
            case .fetchFailed: "Laden ist fehlgeschlagen"
            }
        }
    }
    
    func fetchArt() {
        Task {
            do {
                guard let objectIds = try await getArtObjects().objectIDs else { return }
                
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

    private func getArtObjects() async throws -> ArtObjectResponse {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/search?isHighlight=true&q=china"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ArtObjectResponse.self, from: data)
    }

    private func fetchArtObjectDetails(for objectId: Int) async throws -> ArtObject {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(objectId)"
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ArtObject.self, from: data)
    }
}
