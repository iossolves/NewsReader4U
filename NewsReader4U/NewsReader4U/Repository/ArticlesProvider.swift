//
//  ArticlesProvider.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Combine
import Foundation

class ArticlesProvider: ArticlesRepository {
    func getArticles(for category: String, countryCode: String) -> AnyPublisher<[Article], Error> {
        let newsService = NewsService()
        return newsService.getTopHeadlines(category: category, countryCode: countryCode)
            .map { $0.articles }
            .eraseToAnyPublisher()
    }
}

class MockArticlesProvider: ArticlesRepository {
    
    func getArticles(for category: String, countryCode: String) -> AnyPublisher<[Article], Error> {
        return JSONReader.getArticlesFromJSON()
            .map { $0 }
            .eraseToAnyPublisher()
    }
}

class JSONReader {
    
    static func getArticlesFromJSON() -> [Article]? {
        guard let jsonData = readJSONFromFile() else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 // Assuming dates are in ISO8601 format
            let newsResponse  = try decoder.decode(NewsResponse.self, from: jsonData)
            return newsResponse.articles
        } catch {
            print("Error decoding JSON into Article objects:", error)
            return nil
        }
    }
    
    static func getArticlesFromJSON() -> AnyPublisher<[Article], Error> {
        Future<[Article], Error> { promise in
            guard let jsonData = readJSONFromFile() else {
                promise(.failure(NSError(domain: "No JSON data found", code: 1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // Assuming dates are in ISO8601 format
                let newsResponse  = try decoder.decode(NewsResponse.self, from: jsonData)
                promise(.success(newsResponse.articles))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    private static func readJSONFromFile() -> Data? {
        if let path = Bundle.main.path(forResource: "articles", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("Error reading JSON from file:", error)
            }
        }
        return nil
    }
}
