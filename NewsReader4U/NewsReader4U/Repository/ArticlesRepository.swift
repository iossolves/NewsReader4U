//
//  ArticlesRepository.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Foundation
import Combine

protocol ArticlesRepository {
    func getArticles(for category: String, countryCode: String) -> AnyPublisher<[Article], Error>
}
