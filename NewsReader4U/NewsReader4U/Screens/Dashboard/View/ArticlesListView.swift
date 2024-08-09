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
            ArticleRowView(article: article)
        }
        .listStyle(.plain)
    }
}
