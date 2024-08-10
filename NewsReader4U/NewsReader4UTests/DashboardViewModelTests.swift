//
//  DashboardViewModelTests.swift
//  NewsReader4UTests
//
//  Created by Karunakar Bandikatla on 10/08/24.
//

import XCTest
import Combine
@testable import NewsReader4U

final class DashboardViewModelTests: XCTestCase {
    
    var viewModel: DashboardViewModel!
    var mockCategoriesRepository: MockCategoriesProvider!
    var mockArticlesRepository: MockArticlesProvider!
    var mockAnalyticsFacade: MockAnalyticsFacade!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockCategoriesRepository = MockCategoriesProvider()
        mockArticlesRepository = MockArticlesProvider()
        mockAnalyticsFacade = MockAnalyticsFacade(strategies: [])
        viewModel = DashboardViewModel(categoriesRepository: mockCategoriesRepository, articlesRepository: mockArticlesRepository)
        viewModel.analyticsFacade = mockAnalyticsFacade
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockCategoriesRepository = nil
        mockArticlesRepository = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchCategoriesUpdatesCategoriesAndFetchesArticles() {
        viewModel.fetchCategories()
        let expectation = XCTestExpectation(description: "Wait for fetchCategories to complete")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.categories.count, 4, "DashboardViewModel's fetchCategories() error.")
            XCTAssertEqual(self.viewModel.selectedCategoryID, 1, "Selected category ID should be 1 by default")
            XCTAssertTrue(self.mockArticlesRepository.didCallGetArticles, "getArticles(for:) should be called")
            XCTAssertEqual(self.mockArticlesRepository.requestedCategoryName, "business", "getArticles(for:) should be called with the correct category name")
            XCTAssertEqual(self.viewModel.articles.count, 12, "DashboardViewModel's fetchArticles() error.")
            XCTAssertFalse(self.viewModel.isLoading, "DashboardViewModel should set isLoading to false after fetching articles.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4.0)
    }
    
    func testOnCategoryChange() {
        viewModel.selectedCategoryID = 2
        let expectation = XCTestExpectation(description: "Wait for fetchCategories to complete")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockArticlesRepository.didCallGetArticles, "getArticles(for:) should be called")
            XCTAssertEqual(self.mockArticlesRepository.requestedCategoryName, "entertainment", "getArticles(for:) should be called with the correct category name")
            XCTAssertEqual(self.viewModel.articles.count, 12, "DashboardViewModel's fetchArticles() error.")
            XCTAssertFalse(self.viewModel.isLoading, "DashboardViewModel should set isLoading to false after fetching articles.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4.0)
    }
    
    func testRefreshArticles() {
        viewModel.refreshArticles()
        XCTAssertTrue(self.mockAnalyticsFacade.didLogEvent, "Analytics event should be logged")
        XCTAssertEqual(self.mockAnalyticsFacade.loggedEventName, "refreshed_news", "Correct event should be logged")
        let expectation = XCTestExpectation(description: "Wait for fetchCategories to complete")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockArticlesRepository.didCallGetArticles, "getArticles(for:) should be called")
            XCTAssertEqual(self.mockArticlesRepository.requestedCategoryName, "business", "getArticles(for:) should be called with the correct category name")
            XCTAssertEqual(self.viewModel.articles.count, 12, "DashboardViewModel's fetchArticles() error.")
            XCTAssertFalse(self.viewModel.isLoading, "DashboardViewModel should set isLoading to false after fetching articles.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 4.0)
        
    }

}
