//
//  ArticleCategory.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Foundation

struct ArticleCategory: Codable, Identifiable, Hashable {
    let id: Int
    let displayName: String
    let requestParameterName: String
}
