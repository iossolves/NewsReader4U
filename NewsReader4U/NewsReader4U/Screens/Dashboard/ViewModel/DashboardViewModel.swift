//
//  DashboardViewModel.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Combine
import Foundation

class DashboardViewModel: ObservableObject {
    
    @Published var selectedCategoryID = 1
    @Published var categories: [ArticleCategory] = []
    @Published var articles: [Article] = []
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private var categoriesRepository: CategoriesRepository
    private var articlesRepository: ArticlesRepository
    var analyticsFacade: AnalyticsFacade?
    
    init(categoriesRepository: CategoriesRepository,
         articlesRepository: ArticlesRepository,
         analyticsFacade: AnalyticsFacade? = nil) {
        self.categoriesRepository = categoriesRepository
        self.articlesRepository = articlesRepository
        self.analyticsFacade = analyticsFacade
        fetchCategories()
        observeSelectedCategoryChanges()
    }
    
    func fetchCategories() {
        Task {
            let fetchedCategories = await categoriesRepository.getCategories()
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.categories = fetchedCategories
                strongSelf.fetchArticles(for: strongSelf.selectedCategoryID)
            }
        }
    }
    
    func refreshArticles() {
        let categoryName = getCategoryName(for: selectedCategoryID)
        analyticsFacade?.logEvent(AppEvent.refreshedNews(categoryName: categoryName))
        fetchArticles(for: selectedCategoryID)
    }
    
    private func observeSelectedCategoryChanges() {
        $selectedCategoryID
            .sink { [weak self] newSelection in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.onCategoryChange(newSelection)
            }
            .store(in: &cancellables)
    }
    
    private func onCategoryChange(_ categoryID: Int) {
        guard let category = getCategory(by: categoryID) else { return }
        print("Category selected: \(category.displayName)")
        analyticsFacade?.logEvent(AppEvent.categorySelected(categoryName: category.displayName))
        fetchArticles(for: categoryID)
    }
    
    private func getCategoryName(for categoryID: Int) -> String {
        guard let category = getCategory(by: categoryID) else { return "" }
        return category.displayName
    }
    
    private func fetchArticles(for categoryId: Int) {
        guard let category = getCategory(by: categoryId) else { return }
        isLoading = true
        
        articlesRepository.getArticles(for: category.requestParameterName, countryCode: countryCode)
            .sink(receiveCompletion: { [weak self] completion in
                guard let strongSelf = self else { return }
                strongSelf.isLoading = false
                switch completion {
                case .finished:
                    print("Finished successfully")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] articles in
                guard let strongSelf = self else { return }
                strongSelf.articles = articles
                print("Total Results: \(articles.count)")
                for article in articles {
                    print("Title: \(article.displayTitle)")
                }
            })
            .store(in: &cancellables)
        
    }
    
    private func getCategory(by id: Int) -> ArticleCategory? {
        return categories.first(where: { $0.id == id })
    }
    
    private var countryCode: String {
        return "CA"//Locale.current.region?.identifier ?? ""
    }
}
