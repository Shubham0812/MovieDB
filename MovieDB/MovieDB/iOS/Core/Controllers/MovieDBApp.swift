//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI

@main
struct MovieDBApp: App {
    
    // MARK: - Variables
    private let persistenceController = PersistenceController.shared

    
    // MARK: - Views
    var body: some Scene {
        WindowGroup {
            TabbedView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}


@MainActor
class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - Variables

}
