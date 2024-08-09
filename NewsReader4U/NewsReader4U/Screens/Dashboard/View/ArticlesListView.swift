//
//  ArticlesListView.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import SwiftUI

struct ArticlesListView: View {
    
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        List(viewModel.articles) { article in
            NavigationLink(destination: ArticleDetailView(viewModel:
                                                            ArticleDetailViewModel(article: article, analyticsFacade: viewModel.analyticsFacade))) {
                ArticleRowView(article: article)
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.refreshArticles()
        }
    }
}
