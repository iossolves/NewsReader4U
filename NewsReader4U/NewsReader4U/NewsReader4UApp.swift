//
//  NewsReader4UApp.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import SwiftUI
import Firebase

struct AnalyticsFacadeKey: EnvironmentKey {
    static let defaultValue = AnalyticsFacade(strategies: [FirebaseAnalyticsStrategy()])
}

extension EnvironmentValues {
    var analyticsFacade: AnalyticsFacade {
        get { self[AnalyticsFacadeKey.self] }
        set { self[AnalyticsFacadeKey.self] = newValue }
    }
}

@main
struct NewsReaderLocalApp: App {
    let analyticsFacade = AnalyticsFacade(strategies: [FirebaseAnalyticsStrategy()])
        
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(\.analyticsFacade, analyticsFacade)
        }
    }
}
