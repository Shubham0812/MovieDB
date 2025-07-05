//
//  SavedMovies.swift
//  MovieDB
//
//  Created by Shubham on 02/07/25.
//

import SwiftUI

struct FavoriteMoviesView: View {
    
    // MARK: - Variables
    @FetchRequest(
        entity: Movie.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.timestamp, ascending: false)],
        predicate: NSPredicate(format: "isFavorite == true"),
        animation: .default)
    
    private var favoriteMovies: FetchedResults<Movie>
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @EnvironmentObject var genreService: GenreService
    @EnvironmentObject var appState: AppState
    
    @State var viewAppeared = false
    
    let animationDuration: TimeInterval = 0.3
    
    // MARK: - Views
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(Array(favoriteMovies.enumerated()), id: \.element.id) { ix, movie in
                        NavigationLink(value: movie) {
                            MovieListView(movie: movie, movieGenre: genreService.getGenres(from: movie.genreIDs), removeAction: {
                                movie.isFavorite = false
                                
                                try? managedObjectContext.save()
                            })
                        }
                    }
                }
                .padding(2)
                .safeAreaPadding(.top, 24)
            }
            .padding(.horizontal, 18)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .semibold))
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevrkon.left")
                        .font(.system(size: 18, weight: .semibold))
                }
            }
            .onAppear() {

            }
            .navigationTitle("Favorite Movies")
            .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        FavoriteMoviesView()
            .environmentObject(GenreService())
            .environment(\.managedObjectContext, PreviewCoreDataProvider.shared.container.viewContext)
    }
}
