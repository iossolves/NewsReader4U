//
//  NewsService.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Foundation
import Combine

class NewsService {
    private let apiKey = "184be0852be1479f9ea689f5054acadf"
    
    func getTopHeadlines(category: String, countryCode: String) -> AnyPublisher<NewsResponse, Error> {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?apiKey=\(apiKey)&country=\(countryCode)&category=\(category)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return NetworkManager.shared.fetchData(url: url)
    }
}
