//
//  AnalyticsManager.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Foundation

protocol AnalyticsEvent {
    var name: String { get }
    var parameters: [String: Any]? { get }
}

protocol AnalyticsStrategy {
    func logEvent(_ event: AnalyticsEvent)
}

class AnalyticsFacade {
    private var strategies: [AnalyticsStrategy]

    init(strategies: [AnalyticsStrategy]) {
        self.strategies = strategies
    }

    func logEvent(_ event: AnalyticsEvent) {
        strategies.forEach { $0.logEvent(event) }
    }
}

class MockAnalyticsFacade: AnalyticsFacade {
    var didLogEvent = false
    var loggedEventName: String?
    
    override func logEvent(_ event: AnalyticsEvent) {
        didLogEvent = true
        loggedEventName = event.name
    }
}
