//
//  CategoriesRepository.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Foundation

protocol CategoriesRepository {
    func getCategories() async -> [ArticleCategory]
}
