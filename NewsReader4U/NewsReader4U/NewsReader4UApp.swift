//
//  NewsReader4UApp.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import SwiftUI
import Firebase

@main
struct NewsReaderLocalApp: App {
        
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }
}
