//
//  ArticleDetailViewModel.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Foundation
import UIKit

class ArticleDetailViewModel: ObservableObject {
    
    @Published var article: Article
    var analyticsFacade: AnalyticsFacade?
    
    init(article: Article) {
        self.article = article
    }
    
    func sendAnalyticsForDetailViewVisit() {
        analyticsFacade?.logEvent(AppEvent.articleViewed(articleName: article.title ?? ""))
    }
    
    func openArticleUrl() {
        if let urlString = article.url,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
