//
//  Article.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Foundation

struct Article: Codable, Identifiable {
    var id: UUID
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Attempt to decode id, or assign a new UUID if decoding fails
        if let idString = try container.decodeIfPresent(String.self, forKey: .id),
           let uuid = UUID(uuidString: idString) {
            self.id = uuid
        } else {
            self.id = UUID()
        }
        
        // Decode other properties
        self.source = try container.decodeIfPresent(Source.self, forKey: .source)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
    }
    
    var publishedDate: String {
        guard let date = publishedAt?.convertIntoDate() else { return "" }
        return date.format("MMM. dd, yyyy")
    }

    var displayTitle: String {
        title ?? "No Title Available"
    }
    
    var displayAuthor: String {
        author ?? "Unknown Author"
    }
    
    var displayDescription: String {
        description ?? ""
    }
    
    var displayContent: String {
        content ?? ""
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
