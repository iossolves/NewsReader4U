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
    
    init(article: Article, analyticsFacade: AnalyticsFacade? = nil) {
        self.article = article
        analyticsFacade?.logEvent(AppEvent.articleViewed(articleName: article.title ?? ""))
    }
    
    func openArticleUrl() {
        if let urlString = article.url,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
