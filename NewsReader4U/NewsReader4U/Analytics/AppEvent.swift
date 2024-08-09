//
//  AppEvent.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Foundation

enum AppEvent: AnalyticsEvent {
    case categorySelected(categoryName: String)
    case articleViewed(articleId: String)
    case refreshedNews(source: String)
    
    var name: String {
        switch self {
        case .categorySelected:
            return "category_selected"
        case .articleViewed:
            return "article_viewed"
        case .refreshedNews:
            return "refreshed_news"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .categorySelected(let categoryName):
            return EventParameterBuilder.buildCategorySelectedParameters(categoryName: categoryName)
        case .articleViewed(let articleName):
            return EventParameterBuilder.buildArticleViewedParameters(articleName: articleName)
        case .refreshedNews(let categoryName):
            return EventParameterBuilder.buildRefreshedNewsParameters(categoryName: categoryName)
        }
    }
}

private struct EventParameterBuilder {
    static func buildCategorySelectedParameters(categoryName: String) -> [String: Any] {
        return ["category_name": categoryName]
    }
    
    static func buildArticleViewedParameters(articleName: String) -> [String: Any] {
        return ["article_name": articleName]
    }
    
    static func buildRefreshedNewsParameters(categoryName: String) -> [String: Any] {
        return ["category_name": categoryName]
    }
}
