//
//  RepoProtocol.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 11.10.24.
//

import Foundation

protocol Repository {
    
    func getArtObjects(suche: String) async throws -> ArtObjectResponse
    func fetchArtObjectDetails(for objectId: Int) async throws -> ArtObject
    
}

