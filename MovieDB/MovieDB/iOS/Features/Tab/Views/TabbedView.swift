//
//  TabbedView.swift
//  MovieDB
//
//  Created by Shubham on 04/07/25.
//

import SwiftUI

struct TabbedView: View {

    // MARK: - Variables
    @Environment(\.managedObjectContext) private var managedObjectContext
    @StateObject var mainViewModel: MainViewModel = .init()

    @State var selectedTabIndex = 0
    @StateObject var genreService: GenreService = .init()
    @StateObject var appState: AppState = .init()
    
    // MARK: - Views
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            MainView()
                .tag(0)
                .tabItem { Label("Home", systemImage: "house.fill") }
            
            NavigationStack {
                SearchMoviesView()
            }
            .tag(2)
            .tabItem { Label("Search", systemImage: "magnifyingglass") }
        }
        .accentColor(Color.blue)
        .environmentObject(genreService)
        .environmentObject(mainViewModel)
        .onAppear() {
            genreService.loadData(modelContext: managedObjectContext)
        }
    }
}

#Preview {
    TabbedView()
        .environment(\.managedObjectContext, PersistenceController.shared.viewContext)
}
