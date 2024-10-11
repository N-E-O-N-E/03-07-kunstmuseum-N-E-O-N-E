//
//  ArtRepository.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 10.10.24.
//

import SwiftUI

class ArtRepository: Repository {
    
    enum HTTPError: Error {
        case invalidURL, fetchFailed
        var message: String {
            switch self {
            case .invalidURL: "Die URL ist ungültig"
            case .fetchFailed: "Laden ist fehlgeschlagen"
            }
        }
    }
    
    func getArtObjects(suche: String) async throws -> ArtObjectResponse {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/search?q=\(suche)"
        guard let url = URL(string: urlString) else { throw HTTPError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ArtObjectResponse.self, from: data)
    }
    
    func fetchArtObjectDetails(for objectId: Int) async throws -> ArtObject {
        let urlString = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(objectId)"
        guard let url = URL(string: urlString) else { throw HTTPError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ArtObject.self, from: data)
        
    }
    
}
