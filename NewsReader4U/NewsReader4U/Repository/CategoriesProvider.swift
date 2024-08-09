//
//  CategoriesProvider.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Combine

class CategoriesProvider: CategoriesRepository {
    func getCategories() async -> [ArticleCategory] {
        return [ ArticleCategory(id: 1, displayName: "Business", requestParameterName: "business"),
                 ArticleCategory(id: 2, displayName: "Entertainment", requestParameterName: "entertainment"),
                 ArticleCategory(id: 3, displayName: "General", requestParameterName: "general"),
                 ArticleCategory(id: 4, displayName: "Health", requestParameterName: "health"),
                 ArticleCategory(id: 5, displayName: "Science", requestParameterName: "science"),
                 ArticleCategory(id: 6, displayName: "Sports", requestParameterName: "sports"),
                 ArticleCategory(id: 7, displayName: "Technology", requestParameterName: "technology")
        ]
    }
}

class MockCategoriesProvider: CategoriesRepository {
    func getCategories() async -> [ArticleCategory] {
        // Return hardcoded categories for testing
        return [ ArticleCategory(id: 1, displayName: "Business", requestParameterName: "business"),
                 ArticleCategory(id: 2, displayName: "Entertainment", requestParameterName: "entertainment"),
                 ArticleCategory(id: 3, displayName: "Health", requestParameterName: "health"),
                 ArticleCategory(id: 4, displayName: "Technology", requestParameterName: "technology")
        ]
    }
}
