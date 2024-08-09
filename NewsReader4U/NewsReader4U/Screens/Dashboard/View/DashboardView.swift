//
//  DashboardView.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject private var viewModel = DashboardViewModel(categoriesRepository: CategoriesProvider(), articlesRepository: ArticlesProvider())
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CategoriesSelectionView(selectedId: $viewModel.selectedCategoryID, categories: viewModel.categories)
                Spacer(minLength: 16)
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(2.0)
                        .frame(width: 100, height: 100)
                } else {
                    ArticlesListView(viewModel: viewModel)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                }
                Spacer()
            }
            .navigationBarTitle("Latest News")
        }
    }
}
