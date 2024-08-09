//
//  Firebase.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import Foundation
import FirebaseAnalytics

class FirebaseAnalyticsStrategy: AnalyticsStrategy {
    func logEvent(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }
}
