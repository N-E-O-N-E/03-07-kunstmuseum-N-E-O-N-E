//
//  ArtObject.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 08.10.24.
//

import Foundation

struct ArtObject: Codable, Identifiable {
    
    var id: Int {
        objectID
    }
    
    var objectID: Int
    var title: String
    var artistDisplayName: String
    var primaryImage: String?
    
}

